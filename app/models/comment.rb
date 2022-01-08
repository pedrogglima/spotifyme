# frozen_string_literal: true

class Comment < ApplicationRecord
  extend CommentQuery

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  ALLOWED_TYPES = %w[Posts::User].freeze

  validates :commentable_id, presence: true
  validates :commentable_type, presence: true, inclusion: { in: ALLOWED_TYPES }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }

  def self.new_with_defaults(posts_user_id:)
    new(commentable_id: posts_user_id, commentable_type: 'Posts::User')
  end

  def polymorphic_class_name
    commentable_type.demodulize.downcase
  end

  # Called when a new post is created.
  # New posts are default as disliked - hence, nil.
  # Method used on build partials for hotwire
  def like_id
    nil
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
