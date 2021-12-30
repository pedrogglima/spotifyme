# frozen_string_literal: true

class Feed < ApplicationRecord
  extend FeedQuery

  belongs_to :post
  belongs_to :user

  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :visiable, inclusion: { in: [true, false] }
end
