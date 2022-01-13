# frozen_string_literal: true

class Notification < ApplicationRecord
  extend NotificationQuery

  belongs_to :destinatary, class_name: 'User', foreign_key: 'destinatary_id'
  belongs_to :notificable, polymorphic: true, dependent: :destroy

  ALLOWED_TYPES = %w[Notifications::OfLike Notifications::OfInvite].freeze

  validates :destinatary_id, presence: true
  validates :notificable, presence: true
  validates :notificable_type, presence: true, inclusion: { in: ALLOWED_TYPES }
end
