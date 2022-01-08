# frozen_string_literal: true

class Post < ApplicationRecord
  extend PostQuery

  ALLOWED_TYPES = %w[Posts::User].freeze

  belongs_to :user
  belongs_to :postable, polymorphic: true, dependent: :destroy
  # TODO: fix queries
  # has_many :comments, through: post, source: :commentable, source_type: 'Posts::User'
  # has_many :likes, through: post, source: :likeable, source_type: 'Posts::User'

  validates :user_id, presence: true
  validates :postable, presence: true
  validates :postable_type, presence: true, inclusion: { in: ALLOWED_TYPES }

  def posts_user_id
    postable.id
  end

  def posts_user_content
    postable.content
  end

  def posts_user_counter_likeable
    postable.counter_likeable
  end

  def user_id
    user.id
  end

  def user_name
    user.uid
  end

  def user_nickname
    user.nickname
  end

  def like_id
    postable.like_id
  end
end
