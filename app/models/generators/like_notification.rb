# frozen_string_literal: true

module Generators
  class LikeNotification < Base
    def initialize(post_id:)
      @post = Post.find(post_id)
      @last_notification = ::Notification.where(notificable_type: 'Notifications::OfLike',
                                                destinatary_id: @post.user_id).joins(:notificable).last
    end

    def delivery_from(sender_id)
      return unless past_period_of_waiting_for_next_notification

      sender = User.find(sender_id)

      ::Notification.create(
        destinatary: @post.user,
        notificable: ::Notification::OfLike.create(content: "#{sender.name} liked your post")
      )
    end

    private

    def past_period_of_waiting_for_next_notification
      @last_notification.nil? || @last_notification.created_at < 6.hours.ago
    end
  end
end
