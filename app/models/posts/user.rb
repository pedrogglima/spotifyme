# frozen_string_literal: true

module Posts
  class User < ApplicationRecord
    has_one :post, as: :postable, dependent: :destroy
    has_many :likes, as: :likeable, class_name: 'Like', dependent: :destroy
    has_many :comments, as: :commentable, dependent: :destroy

    accepts_nested_attributes_for :post

    validates :content, presence: true, length: { maximum: 500 }

    # Called when a new post is created.
    # New posts are default as disliked - hence, nil.
    # Method used on build partials for hotwire
    def like_id
      nil
    end

    def user_id
      post.user.id
    end

    def user_name
      post.user.username
    end

    def user_nickname
      post.user.nickname
    end

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
