# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, dependent: :destroy

  validates :user_id, presence: true
  validates :likeable_type, presence: true
  validates :likeable_id, presence: true
end
