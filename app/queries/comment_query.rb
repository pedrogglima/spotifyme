# frozen_string_literal: true

module CommentQuery
  def by_posts_user(posts_user_id)
    select(stringify_comments)
      .joins(:user)
      .where(commentable_type: 'Posts::User', commentable_id: posts_user_id)
      .order(created_at: :desc)
  end

  def stringify_comments
    "
      comments.id,
      comments.commentable_id,
      comments.commentable_type,
      comments.content,
      comments.counter_likeable,
      comments.created_at,
      comments.user_id,
      comments.created_at,
      users.uid as user_name,
      users.nickname as user_nickname,
      users.avatar_data as user_avatar
    ".squish.freeze
  end
end
