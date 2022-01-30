# frozen_string_literal: true

module Track
  class CreateService < ApplicationService
    def initialize(user_id, user_uid)
      @current_user = ::User.find(user_id)
      @user = ::RSpotify::User.find(user_uid)
    rescue RestClient::NotFound
      @user = nil
    rescue RestClient::BadRequest
      @user = nil
    rescue SocketError
      @user = nil
    end

    def call
      return if @user.nil?

      # spotify_recently_played.first is the most recent played track
      spotify_recently_played = @user.recently_played

      # avoid posting music that was played a long time ago
      delete_if_past_period_last_played!(spotify_recently_played) unless spotify_recently_played.nil?

      return unless spotify_recently_played.present?

      recently_played = ::Posts::Track.recently_played(@current_user.id)

      # avoid posting multiple musics in short period of time
      return unless past_period_new_post?(recently_played.first)

      # reduce duplicated tracks for reducing comparison time
      uniq_spotify_played = spotify_recently_played.uniq(&:name)
      uniq_played = recently_played.map.uniq(&:name)

      # avoid posting repeated tracks
      new_uniq_tracks = find_new_uniq_tracks(uniq_spotify_played, uniq_played)

      return if new_uniq_tracks.blank?

      popular_track = new_uniq_tracks.max_by(&:popularity)

      track = new_track(popular_track)

      track.save!

      ::Feed::CreateWorker.perform_async(track.post.id)
    end

    def new_track(track)
      resource_params = {
        user_id: @current_user.id,
        name: track.name,
        played_at: track.played_at,
        duration_ms: track.duration_ms,
        popularity: track.popularity,
        track_url: track.external_urls['spotify'],
        artists_name: track.artists.map(&:name),
        artists_url: track.artists.map { |a| a.external_urls['spotify'] },
        album_name: track.album.name,
        album_url: track.album.external_urls['spotify'],
        spotify_image_urls: format_image_urls(track.album.images)
      }

      ::Posts::Track.build_with_post(resource_params, @current_user)
    end

    # avoid posting repeated tracks
    def find_new_uniq_tracks(spotify_tracks, user_tracks)
      spotify_tracks.delete_if do |track|
        user_tracks.any? { |user_track| user_track.name == track.name }
      end
    end

    # avoid posting music that was played a long time ago
    def delete_if_past_period_last_played!(recently_played)
      min_period = ::Settings.posts.min_period.last_played.seconds

      recently_played.delete_if do |track|
        track.played_at.to_datetime < min_period.ago
      end
    end

    # avoid posting multiple musics in short period of time
    def past_period_new_post?(track)
      return true if track.nil?

      min_period = ::Settings.posts.min_period.last_track.seconds

      track.created_at < min_period.ago
    end

    def format_image_urls(images_info)
      images_info.map do |image_info|
        "#{image_info['width']};#{image_info['height']};#{image_info['url']}"
      end
    end
  end
end
