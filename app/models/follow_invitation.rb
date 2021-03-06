# frozen_string_literal: true

class FollowInvitation < ApplicationRecord
  extend FollowInvitationQuery

  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id', counter_cache: :counter_follower
  belongs_to :following, class_name: 'User', foreign_key: 'following_id', counter_cache: :counter_following

  scope :followers_from, ->(user_id) { where(following_id: user_id, status: :accepted) }

  after_create_commit { ::Notifications::InviteWorker.perform_async(follower_id, following_id) }

  before_create :set_status

  enum status: %i[pending accepted rejected ignored blocked]

  validates :follower_id, presence: true, uniqueness: { scope: :following_id }
  validates :following_id, presence: true, uniqueness: { scope: :follower_id }
  validates :status, presence: true

  def set_status
    self.status = :pending
  end
end
