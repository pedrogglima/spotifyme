# frozen_string_literal: true

class Comment < ApplicationRecord
  extend CommentQuery

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  ALLOWED_TYPES = %w[PostType::Simple].freeze

  validates :commentable_id, presence: true
  validates :commentable_type, presence: true, inclusion: { in: ALLOWED_TYPES }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
  validates :like_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.new_with_defaults(simple_id:)
    new(commentable_id: simple_id, commentable_type: 'PostType::Simple')
  end

  def user_id
    user.id
  end

  def user_nickname
    user.nickname
  end

  def user_name
    user.username
  end
end
