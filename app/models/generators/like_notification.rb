# frozen_string_literal: true

module Generators
  class LikeNotification < Base
    def initialize(args)
      @post = ::Post.find_by(id: args[:post_id])
    end

    def deliver_from(follower_id)
      # do nothing if @post is already deleted
      return if @post.nil?

      follower = ::User.find(follower_id)

      # don't notificate if current user liked his own post
      return if follower.id == @post.user_id

      @last_notification = ::Notification.of_like_last_notification(@post.user_id,
                                                                    @post.id).first

      # don't notificate if user already got a notification in the last x hours
      return unless past_period_of_waiting_for_next_notification

      ::Notifications::OfLike.build_with_notification(
        {
          post: @post,
          content: liked_message(@post, follower)
        },
        @post.user_id
      ).save!
    end

    def liked_message(post, follower)
      if post.postable.counter_likeable >= 3
        "#{follower.username} and #{post.postable.counter_likeable} other persons liked your post"
      else
        "#{follower.username} liked your post"
      end
    end

    private

    def past_period_of_waiting_for_next_notification
      @last_notification.nil? || @last_notification.created_at < 6.hours.ago
    end
  end
end
