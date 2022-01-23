# frozen_string_literal: true

module PostsUserQuery
  def by_user(user_id)
    select(stringify_feeds)
      .joins(:user)
      .joins("LEFT JOIN likes AS likes ON likes.likeable_type = 'Posts::User' AND likes.likeable_id = posts_users.id AND likes.user_id = #{user_id}")
      .where(user_id: user_id)
      .order(created_at: :desc)
  end

  def stringify_feeds
    "
      posts_users.id,
      posts_users.content,
      posts_users.counter_likeable,
      posts_users.created_at,
      users.id as user_id,
      users.uid as user_name,
      users.nickname as user_nickname,
      users.avatar_data as user_avatar,
      likes.id as posts_user_like_id
    ".squish.freeze
  end
end
