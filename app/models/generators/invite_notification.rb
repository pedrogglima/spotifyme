# frozen_string_literal: true

module Generators
  class InviteNotification < Base
    def initialize(args)
      @following = User.find(args[:following_id])
    end

    def deliver_from(follower_id)
      follower = User.find(follower_id)

      ::Notifications::OfInvite.build_with_notification(
        { content: invite_message(follower) },
        @following.id
      ).save
    end

    private

    def invite_message(follower)
      "#{follower.username} wants to follow you."
    end
  end
end
