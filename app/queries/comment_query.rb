# frozen_string_literal: true

module CommentQuery
  def by_posts_user(current_user_id, commentable_type, commentable_id)
    select(stringify_comments)
      .joins(:user)
      .joins("LEFT JOIN likes AS likes ON likes.likeable_type = 'Comment' AND likes.likeable_id = comments.id AND likes.user_id = #{current_user_id}")
      .where(commentable_type: commentable_type, commentable_id: commentable_id)
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
      users.avatar_data as user_avatar,
      likes.id as comment_like_id
    ".squish.freeze
  end
end
