# frozen_string_literal: true

module FeedQuery
  def by_user(user_id)
    select(stringify_feeds)
      .joins(post: :user)
      .joins("INNER JOIN post_type_simples ON posts.postable_type = 'PostType::Simple' AND posts.postable_id = post_type_simples.id")
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
      posts.user_id as post_user_id,
      post_type_simples.content as post_simple_content
    ".squish.freeze
  end
end
