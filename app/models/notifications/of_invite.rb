# frozen_string_literal: true

class Notifications::OfInvite < ApplicationRecord
  has_one :notification, as: :notificable, dependent: :destroy

  validates :content, presence: true
  validates :seen, inclusion: { in: [true, false] }
end
