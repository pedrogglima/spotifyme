# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: :counter_likeable

  ALLOWED_TYPES = %w[PostType::Simple].freeze

  validates :user_id, presence: true
  validates :likeable_type, presence: true
  validates :likeable_id, presence: true

  def self.new_with_defaults(simple_id:, user_id:)
    new(likeable_id: simple_id, likeable_type: 'PostType::Simple', user_id: user_id)
  end
end
