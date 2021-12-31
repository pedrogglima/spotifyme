# frozen_string_literal: true

class FollowInvitation < ApplicationRecord
  extend FollowInvitationQuery

  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following, class_name: 'User', foreign_key: 'following_id'

  after_create_commit do
    broadcast_prepend_to "user_#{following_id}:follow_invitations"
  end

  after_update_commit do
    broadcast_remove_to "user_#{following_id}:follow_invitations" if status != :pending
  end

  enum status: %i[pending accepted rejected ignored blocked]

  validates :follower_id, presence: true
  validates :following_id, presence: true
  validates :status, presence: true

  def nickname
    follower.nickname
  end

  def username
    follower.username
  end
end
