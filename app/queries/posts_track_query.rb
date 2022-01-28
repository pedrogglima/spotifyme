# frozen_string_literal: true

module PostsTrackQuery
  def by_user(user_id)
    select(stringify_profile)
      .joins(:user)
      .joins("LEFT JOIN likes AS likes ON likes.likeable_type = 'Posts::Track' AND likes.likeable_id = posts_tracks.id AND likes.user_id = #{user_id}")
      .where(user_id: user_id, deleted: false)
      .order(created_at: :desc)
  end

  def stringify_profile
    "
      posts_tracks.id,
      posts_tracks.name,
      posts_tracks.played_at,
      posts_tracks.duration_ms,
      posts_tracks.popularity,
      posts_tracks.track_url,
      posts_tracks.album_name,
      posts_tracks.album_url,
      posts_tracks.artists_name,
      posts_tracks.artists_url,
      posts_tracks.image_data,
      posts_tracks.counter_likeable,
      posts_tracks.created_at,
      users.id as user_id,
      users.uid as user_name,
      users.nickname as user_nickname,
      users.avatar_data as user_avatar,
      likes.id as posts_track_like_id
    ".squish.freeze
  end
end
