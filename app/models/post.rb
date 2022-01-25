# frozen_string_literal: true

class Post < ApplicationRecord
  extend PostQuery

  belongs_to :user
  belongs_to :postable, polymorphic: true, dependent: :destroy
  has_many :feeds, dependent: :destroy
  has_many :like_notifications,
           class_name: 'Notifications::OfLike',
           dependent: :destroy
  # TODO: fix queries
  # has_many :comments, through: post, source: :commentable, source_type: 'Posts::User'
  # has_many :likes, through: post, source: :likeable, source_type: 'Posts::User'

  ALLOWED_TYPES = %w[Posts::User Posts::Track].freeze

  validates :user_id, presence: true
  validates :postable, presence: true
  validates :postable_type, presence: true, inclusion: { in: ALLOWED_TYPES }

  def polymorphic_class_name
    postable_type.demodulize.downcase
  end
end
