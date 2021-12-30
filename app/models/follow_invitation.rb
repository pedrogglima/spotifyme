# frozen_string_literal: true

class FollowInvitation < ApplicationRecord
  extend FollowInvitationQuery

  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following, class_name: 'User', foreign_key: 'following_id'

  enum status: %i[pending accepted rejected ignored blocked]

  validates :follower_id, presence: true
  validates :following_id, presence: true
  validates :status, presence: true
end
