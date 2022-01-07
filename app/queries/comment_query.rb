# frozen_string_literal: true

module CommentQuery
  def by_simple(simple_id)
    select(stringify_comments)
      .joins(:user)
      .where(commentable_type: 'PostType::Simple', commentable_id: simple_id)
      .order(created_at: :desc)
  end

  def stringify_comments
    "
      comments.id,
      comments.commentable_id,
      comments.commentable_type,
      comments.content,
      comments.like_count,
      comments.created_at,
      comments.user_id,
      comments.created_at,
      users.uid as user_name,
      users.nickname as user_nickname
    ".squish.freeze
  end
end
