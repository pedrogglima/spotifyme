# frozen_string_literal: true

module PostType
  class Simple < ApplicationRecord
    has_one :post, as: :postable, dependent: :destroy
    has_many :likes, as: :likeable, class_name: 'PostLike', dependent: :destroy
    has_many :comments, as: :commentable, dependent: :destroy

    validates :content, presence: true, length: { maximum: 500 }
  end
end
