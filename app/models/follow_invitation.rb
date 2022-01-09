# frozen_string_literal: true

class FollowInvitation < ApplicationRecord
  extend FollowInvitationQuery

  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following, class_name: 'User', foreign_key: 'following_id'

  after_create_commit do
    broadcast_prepend_later_to "user_#{following_id}:follow_invitations"
  end

  before_create :set_status

  enum status: %i[pending accepted rejected ignored blocked]

  validates :follower_id, presence: true
  validates :following_id, presence: true
  validates :status, presence: true

  def set_status
    self.status = :pending
  end

  def follower_user_id
    follower.id
  end

  def follower_nickname
    follower.nickname
  end

  def follower_username
    follower.username
  end
end
