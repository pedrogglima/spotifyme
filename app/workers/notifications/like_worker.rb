# frozen_string_literal: true

class Notifications::LikeWorker < BaseWorker
  include Sidekiq::Worker

  def perform(post_id, follower_id)
    args = { post_id: post_id }

    ::Generators::LikeNotification.with(args)
                                  .deliver_from(follower_id)
  end
end
