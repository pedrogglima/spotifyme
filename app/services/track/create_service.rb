# frozen_string_literal: true

module Track
  class CreateService < ApplicationService
    def initialize(user_id, user_uid)
      @user_id = user_id
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

      spotify_recently_played = @user.recently_played

      return if spotify_recently_played.empty?

      recently_tracks = Posts::Track.recently_tracks(@user_id)

      return unless past_period_for_new_post?(recently_tracks.first)

      uniq_spotify_played = spotify_recently_played.uniq(&:name)
      uniq_tracks = recently_tracks.map.uniq(&:name)

      new_uniq_tracks = find_new_uniq_tracks(uniq_spotify_played, uniq_tracks)

      return if new_uniq_tracks.empty?

      popular_track = new_uniq_tracks.max_by(&:popularity)

      track = new_track(popular_track)

      track.save!
    end

    def new_track(track)
      Posts::Track.new(
        user_id: @user_id,
        name: track.name,
        played_at: track.played_at,
        duration_ms: track.duration_ms,
        popularity: track.popularity,
        track_url: track.external_urls['spotify'],
        artists_name: track.artists.map(&:name).join(', '),
        artists_url: track.artists.map { |a| a.external_urls['spotify'] }.join(', '),
        album_name: track.album.name,
        album_url: track.album.external_urls['spotify'],
        spotify_image_urls: format_image_urls(track.album.images)
      )
    end

    def find_new_uniq_tracks(spotify_tracks, user_tracks)
      spotify_tracks.select do |track|
        res = user_tracks.any? { |user_track| user_track.name == track.name }

        res.nil? ? false : true
      end
    end

    def past_period_for_new_post?(track)
      return true if track.nil?

      min_period = Settings.posts.min_period.track.seconds

      track.created_at.to_datetime < min_period.ago
    end

    def format_image_urls(images_info)
      images_info.map do |image_info|
        "#{image_info['width']};#{image_info['height']};#{image_info['url']}"
      end
    end
  end
end
