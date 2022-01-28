# frozen_string_literal: true

class Feed
  class DestroyWorker < BaseWorker
    include Sidekiq::Worker

    def perform(post_id)
      ::Post.find(post_id).destroy
    end
  end
end
