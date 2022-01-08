# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: :counter_likeable

  ALLOWED_TYPES = %w[Posts::User Comment].freeze

  after_create_commit do
    if likeable.counter_likeable <= 3
      broadcast_replace_to(
        broadcast_channel,
        target: "likes_#{likeable.id}",
        partial: 'likes/likes',
        locals: { resource: self }
      )
    end
  end

  after_destroy_commit do
    if likeable.counter_likeable <= 3
      broadcast_replace_to(
        broadcast_channel,
        target: "likes_#{likeable.id}",
        partial: 'likes/likes',
        locals: { resource: self }
      )
    end
  end

  validates :user_id, presence: true
  validates :likeable_id, presence: true
  validates :likeable_type, presence: true, inclusion: { in: ALLOWED_TYPES }

  def self.new_with_defaults(posts_user_id:, user_id:)
    new(likeable_id: posts_user_id, likeable_type: 'Posts::User', user_id: user_id)
  end

  def polymorphic_class_name
    likeable_type.demodulize.downcase
  end

  def broadcast_channel
    case likeable_type
    when 'Posts::User'
      "user_#{user.id}:posts"
    when 'Comment'
      "user_#{user.id}:comments"
    end
  end
end
