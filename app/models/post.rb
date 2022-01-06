# frozen_string_literal: true

class Post < ApplicationRecord
  extend PostQuery

  belongs_to :user
  belongs_to :postable, polymorphic: true, dependent: :destroy
  # TODO: fix queries
  # has_many :comments, through: post, source: :commentable, source_type: 'PostType::Simple'
  # has_many :likes, through: post, source: :likeable, source_type: 'PostType::Simple'

  validates :user_id, presence: true
  validates :postable, presence: true

  def simple_id
    postable.id
  end

  def simple_content
    postable.content
  end

  def simple_counter_likeable
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
