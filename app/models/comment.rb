# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
  validates :like_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
