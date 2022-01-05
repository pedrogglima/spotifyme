# frozen_string_literal: true

module PostType
  class Simple < ApplicationRecord
    has_one :post, as: :postable, dependent: :destroy
    has_many :likes, as: :likeable, class_name: 'PostLike', dependent: :destroy
    has_many :comments, as: :commentable, dependent: :destroy

    accepts_nested_attributes_for :post

    validates :content, presence: true, length: { maximum: 500 }

    # Fix for nested attr. association polymorphic
    def post_attributes=(attribute_set)
      super(attribute_set.merge(postable: self))
    end

    # Fix for nested attr. association polymorphic
    def self.build_with_post(params, current_user)
      new_params = params.to_h
                         .deep_merge!(
                           post_attributes: {
                             user_id: current_user.id,
                             postable_type: name
                           }
                         )

      new(new_params)
    end
  end
end
