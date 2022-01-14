# frozen_string_literal: true

module Generators
  class LikeNotification < Base
    def initialize(params)
      @post = Post.find(params[:post_id])
      @last_notification = ::Notification.of_like_last_notification(@post.user.id, @post.id).first
    end

    def delivery_from(sender_id)
      return unless past_period_of_waiting_for_next_notification

      sender = User.find(sender_id)

      ::Notifications::OfLike.create(
        post: @post,
        content: liked_message(@post, sender),
        notification_attributes: {
          destinatary: sender,
          notificable_type: 'Notifications::OfLike'
        }
      )
    end

    def liked_message(post, follower)
      if post.postable.counter_likeable >= 3
        "#{follower.username} and #{post.postable.counter_likeable} persons liked your post"
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
