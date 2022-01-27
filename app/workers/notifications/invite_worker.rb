# frozen_string_literal: true

module Notifications
  class InviteWorker < BaseWorker
    include Sidekiq::Worker

    def perform(follower_id, following_id)
      args = { following_id: following_id }

      ::Generators::InviteNotification.with(args)
                                      .deliver_from(follower_id)
    end
  end
end
