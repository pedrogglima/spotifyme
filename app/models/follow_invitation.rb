# frozen_string_literal: true

class FollowInvitation < ApplicationRecord
  extend FollowInvitationQuery

  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following, class_name: 'User', foreign_key: 'following_id'

  before_create :set_status

  enum status: %i[pending accepted rejected ignored blocked]

  validates :follower_id, presence: true, uniqueness: { scope: :following_id }
  validates :following_id, presence: true, uniqueness: { scope: :follower_id }
  validates :status, presence: true

  def set_status
    self.status = :pending
  end
end
