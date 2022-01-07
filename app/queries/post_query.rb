# frozen_string_literal: true

module PostQuery
  def by_user(user_id)
    select(stringify_feeds)
      .joins("LEFT JOIN posts_users AS posts_users ON posts.postable_type = 'Posts::User' AND posts.postable_id = posts_users.id")
      .joins("LEFT JOIN likes AS likes ON likes.likeable_type = 'Posts::User' AND likes.likeable_id = posts_users.id AND likes.user_id = #{user_id}")
      .joins(:user)
      .where(user_id: user_id)
      .order(created_at: :desc)
  end

  def stringify_feeds
    "
      posts.id,
      posts.postable_type,
      posts.postable_id,
      posts.created_at,
      posts_users as posts_user_id,
      posts_users.content as posts_user_content,
      posts_users.counter_likeable as posts_user_counter_likeable,
      users.id as user_id,
      users.uid as user_name,
      users.nickname as user_nickname,
      likes.id as like_id
    ".squish.freeze
  end
end
