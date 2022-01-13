# frozen_string_literal: true

class Notifications::OfLike < ApplicationRecord
  has_one :notification, as: :notificable, dependent: :destroy
  belongs_to :post

  validates :content, presence: true
  validates :seen, inclusion: { in: [true, false] }
end
