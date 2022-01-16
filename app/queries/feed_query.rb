# frozen_string_literal: true

module FeedQuery
  def by_user(user_id)
    select(stringify_feeds)
      .joins(post: :user)
      .joins("INNER JOIN posts_users ON posts.postable_type = 'Posts::User' AND posts.postable_id = posts_users.id")
      .joins("LEFT JOIN likes AS likes ON likes.likeable_type = 'Posts::User' AND likes.likeable_id = posts_users.id AND likes.user_id = #{user_id}")
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
      likes.id as like_id
    ".squish.freeze
  end
end
