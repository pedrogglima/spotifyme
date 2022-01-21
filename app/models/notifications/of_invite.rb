# frozen_string_literal: true

class Notifications::OfInvite < ApplicationRecord
  has_one :notification, as: :notificable, dependent: :destroy

  after_create_commit do
    broadcast_replace_to(
      "user_#{notification.destinatary_id}:all",
      target: 'notifications_alert',
      partial: 'notifications/alert'
    )
  end

  accepts_nested_attributes_for :notification

  validates :content, presence: true
  validates :seen, inclusion: { in: [true, false] }

  # Fix for nested attr. association polymorphic
  def notification_attributes=(attribute_set)
    super(attribute_set.merge(notificable: self))
  end

  # Fix for nested attr. association polymorphic
  def self.build_with_notification(params, follower_id)
    new_params = params.to_h
                       .deep_merge!(
                         notification_attributes: {
                           destinatary_id: follower_id
                         }
                       )

    new(new_params)
  end
end
