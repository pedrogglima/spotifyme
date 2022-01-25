# frozen_string_literal: true

module FeedQuery
  def by_user(user_id)
    select(stringify_feeds)
      .joins(post: :user)
      .joins("LEFT JOIN posts_users ON posts.postable_type = 'Posts::User' AND posts_users.id = posts.postable_id")
      .joins("LEFT JOIN posts_tracks ON posts.postable_type = 'Posts::Track' AND posts_tracks.id = posts.postable_id")
      .joins('LEFT JOIN likes AS likes ON likes.likeable_type = posts.postable_type AND likes.likeable_id = posts.postable_id AND likes.user_id = users.id')
      .where(user_id: user_id, visiable: true)
      .order(created_at: :desc)
  end

  def stringify_feeds
    "
      feeds.id,
      feeds.post_id,
      feeds.user_id,
      users.uid as user_name,
      users.nickname as user_nickname,
      users.avatar_data as user_avatar,
      posts.id as post_id,
      posts.postable_type,
      posts.postable_id,
      posts.created_at,
      posts_users.id as posts_user_id,
      posts_users.content as posts_user_content,
      posts_users.counter_likeable as posts_user_counter_likeable,
      posts_tracks.id as track_id,
      posts_tracks.name as track_name,
      posts_tracks.played_at as track_played_at,
      posts_tracks.duration_ms as track_duration_ms,
      posts_tracks.popularity as track_popularity,
      posts_tracks.track_url as track_url,
      posts_tracks.album_name as track_album_name,
      posts_tracks.album_url as track_album_url,
      posts_tracks.artists_name as track_artists_name,
      posts_tracks.artists_url as track_artists_url,
      posts_tracks.image_data as track_image_data,
      posts_tracks.counter_likeable as track_counter_likeable,
      likes.id as like_id
    ".squish.freeze
  end
end
