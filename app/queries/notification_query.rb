# frozen_string_literal: true

module NotificationQuery
  def by_user(user_id)
    select(stringify_all_types)
      .joins("LEFT JOIN notifications_of_likes AS of_likes ON notifications.notificable_type = 'Notifications::OfLike' AND notifications.notificable_id = of_likes.id")
      .joins("LEFT JOIN notifications_of_invites AS of_invites ON notifications.notificable_type = 'Notifications::OfInvite' AND notifications.notificable_id = of_invites.id")
      .where(destinatary_id: user_id)
      .order(created_at: :desc)
  end

  def of_like(user_id)
    select(stringify_notification)
      .joins("LEFT JOIN notifications_of_likes AS of_likes ON notifications.notificable_type = 'Notifications::OfLike' AND notifications.notificable_id = of_likes.id")
      .where(destinatary_id: user_id)
      .order(created_at: :desc)
  end

  def of_like_last_notification(user_id, post_id)
    select(stringify_of_like_last_notification)
      .joins("INNER JOIN notifications_of_likes AS of_likes ON notifications.notificable_type = 'Notifications::OfLike' AND notifications.notificable_id = of_likes.id")
      .where(destinatary_id: user_id, 'of_likes.post_id': post_id)
      .order('of_likes.created_at': :desc)
      .limit(1)
  end

  def stringify_of_like_last_notification
    "
      notifications.id AS id,
      of_likes.id AS of_like_id,
      of_likes.created_at as created_at
    ".squish.freeze
  end

  def stringify_notification
    "
      notifications.id,
      notifications.destinatary_id,
      notifications.notificable_id,
      notifications.notificable_type,
      of_likes.post_id as of_like_post_id,
      of_likes.content as of_like_content,
      of_likes.seen as of_like_seen
    ".squish.freeze
  end

  def stringify_all_types
    "
      notifications.id,
      notifications.destinatary_id,
      notifications.notificable_id,
      notifications.notificable_type,
      notifications.created_at,
      of_likes.id as of_like_id,
      of_likes.post_id as of_like_post_id,
      of_likes.content as of_like_content,
      of_likes.seen as of_like_seen,
      of_invites.id as of_invite_id,
      of_invites.content as of_invite_content,
      of_invites.seen as of_invite_seen
    ".squish.freeze
  end
end
