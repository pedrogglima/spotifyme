# frozen_string_literal: true

module FeedQuery
  def by_user(user_id)
    select(stringify_feeds)
      .joins(post: :user)
      .joins("INNER JOIN posts_users ON posts.postable_type = 'Posts::User' AND posts.postable_id = posts_users.id")
      .where(user_id: user_id, visiable: true)
      .order(created_at: :desc)
  end

  def stringify_feeds
    "
      feeds.id,
      feeds.post_id,
      feeds.user_id,
      feeds.created_at,
      users.uid as user_name,
      users.nickname as user_nickname,
      users.avatar_data as user_avatar,
      posts.user_id as posts_user_id,
      posts_users.content as post_posts_user_content
    ".squish.freeze
  end
end
