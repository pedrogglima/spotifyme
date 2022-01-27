# frozen_string_literal: true

class Feed
  class CreateWorker < BaseWorker
    include Sidekiq::Worker

    def perform(post_id)
      Feed::BatchCreateService.call(post_id)
    end
  end
end
