# frozen_string_literal: true

module Posts
  class Album < ApplicationRecord
    include AlbumUploader::Attachment(:image)
    extend PostsAlbumQuery

    # user assoc. validating on notification
    belongs_to :user, class_name: '::User', foreign_key: 'user_id', optional: true
    has_one :post, as: :postable, dependent: :destroy
    has_many :likes, as: :likeable, class_name: 'Like', dependent: :destroy
    has_many :comments, as: :commentable, dependent: :destroy

    accepts_nested_attributes_for :post

    validates :name, presence: true, length: { maximum: 200 }

    def like_id
      likes.where(follower: user).first
    end

    def polymorphic_class_name
      self.class.name.demodulize.downcase
    end

    # Fix for nested attr. association polymorphic
    def post_attributes=(attribute_set)
      super(attribute_set.merge(postable: self))
    end

    # Fix for nested attr. association polymorphic
    def self.build_with_post(params, current_user)
      new_params = params.to_h
                         .merge!(user_id: current_user.id)
                         .deep_merge!(
                           post_attributes: {
                             user_id: current_user.id
                           }
                         )
      new(new_params)
    end
  end
end
