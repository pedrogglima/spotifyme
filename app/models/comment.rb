# frozen_string_literal: true

class Comment < ApplicationRecord
  extend CommentQuery

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, class_name: 'Like', dependent: :destroy

  ALLOWED_TYPES = %w[Posts::User Posts::Track].freeze

  validates :commentable_id, presence: true
  validates :commentable_type, presence: true, inclusion: { in: ALLOWED_TYPES }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }

  def polymorphic_class_name
    commentable_type.demodulize.downcase
  end

  def like_id
    likes.where(follower: user).first
  end
end
