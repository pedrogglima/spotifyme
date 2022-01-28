# frozen_string_literal: true

module Generators
  class LikeNotification < Base
    def initialize(args)
      @post = ::Post.find_by(id: args[:post_id])
      @last_notification = if @post.present?
                             ::Notification.of_like_last_notification(@post.user_id,
                                                                      @post.id).first
                           end
    end

    def deliver_from(follower_id)
      return unless @post.present? && past_period_of_waiting_for_next_notification

      follower = ::User.find(follower_id)

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
