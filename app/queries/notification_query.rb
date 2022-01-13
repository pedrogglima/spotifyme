# frozen_string_literal: true

module NotificationQuery
  def of_like(user_id, post_id)
    select(stringify_notification)
      .joins("LEFT JOIN notifications_of_likes AS of_likes ON notifications.notificable_type = 'Notifications::OfLike' AND notifications.notificable_id = of_like.id AND of_like.post_id = #{post_id}")
      .where(destinatary_id: user_id)
      .order(created_at: :desc)
  end

  def stringify_notification
    "
      notifications.id,
      notifications.destinatar_id,
      of_likes.content as of_like_content,
      of_likes.seen as of_like_seen,
      users.id as user_id,
      users.uid as user_name,
      users.nickname as user_nickname
    ".squish.freeze
  end
end
