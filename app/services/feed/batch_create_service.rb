# frozen_string_literal: true

class Feed
  class BatchCreateService < ApplicationService
    def initialize(post_id)
      @post = ::Post.find(post_id)
    end

    def call
      feeds_params = ::FollowInvitation.followers_from(@post.user_id).map do |invitation|
        { post_id: @post.id, user_id: invitation.follower_id }
      end

      # add to current user's feed
      feeds_params << { post_id: @post.id, user_id: @post.user_id }

      Feed.insert_all(feeds_params, returning: %i[id post_id user_id])
    end
  end
end
