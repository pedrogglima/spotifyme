# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :postable, polymorphic: true, dependent: :destroy
  # TODO: fix queries
  # has_many :comments, through: post, source: :commentable, source_type: 'PostType::Simple'
  # has_many :likes, through: post, source: :likeable, source_type: 'PostType::Simple'

  accepts_nested_attributes_for :postable

  validates :user_id, presence: true
  validates :postable_type, presence: true
  validates :postable_id, presence: true
end
