# frozen_string_literal: true

module Posts
  class Track < ApplicationRecord
    include TrackUploader::Attachment(:image)
    extend PostsTrackQuery

    # user assoc. validating on notification
    belongs_to :user, class_name: '::User', foreign_key: 'user_id', optional: true
    has_one :post, as: :postable, dependent: :destroy
    has_many :likes, as: :likeable, class_name: 'Like', dependent: :destroy
    has_many :comments, as: :commentable, dependent: :destroy

    after_create_commit :download_image

    scope :recently_tracks, lambda { |user_id, quantity = 20|
                              where(user_id: user_id, deleted: false)
                                .order(created_at: :desc)
                                .limit(quantity)
                            }

    accepts_nested_attributes_for :post

    validates :name, presence: true, length: { maximum: 200 }
    validates :played_at, presence: true, length: { maximum: 200 }
    validates :album_name, presence: true, length: { maximum: 200 }

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

    def download_image
      ::Track::DownloadImageWorker.perform_async(id)
    end

    # spotify_image_urls is an array of urls with format: height;width;url
    # right now Spotify returns 64x64, 300x300, 640x640 sizes.
    # @returns [String, nil]
    #
    def spotify_image_url
      return if spotify_image_urls.blank?

      separator = ';'

      img = spotify_image_urls.find do |image_url|
        image_info = image_url.split(separator)

        width  = image_info[0]
        height = image_info[1]

        width == '300' && height == '300'
      end

      img.present? ? img.split(separator)[2] : spotify_image_urls.first.split(separator)[2]
    end
  end
end
