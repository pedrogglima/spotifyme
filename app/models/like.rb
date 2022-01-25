# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: 'user_id'
  belongs_to :likeable, polymorphic: true, counter_cache: :counter_likeable

  after_create_commit do
    ::Notifications::LikeWorker.perform_async(likeable.post.id, user_id) unless likeable.is_a?(Comment)
  end

  after_create_commit do
    if likeable.counter_likeable <= 3
      broadcast_replace_to(
        "user_#{user_id}:all",
        target: "likes_#{polymorphic_class_name}_#{likeable_id}",
        partial: 'likes/likes',
        locals: { resource: self }
      )
    end
  end

  after_destroy_commit do
    if likeable.counter_likeable <= 3
      broadcast_replace_to(
        "user_#{user_id}:all",
        target: "likes_#{polymorphic_class_name}_#{likeable_id}",
        partial: 'likes/likes',
        locals: { resource: self }
      )
    end
  end

  ALLOWED_TYPES = %w[Posts::User Posts::Track Comment].freeze

  validates :user_id, presence: true
  validates :likeable_id, presence: true
  validates :likeable_type, presence: true, inclusion: { in: ALLOWED_TYPES }

  def polymorphic_class_name
    likeable_type.demodulize.downcase
  end
end
