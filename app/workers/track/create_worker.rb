# frozen_string_literal: true

module Track
  class CreateWorker < BaseWorker
    include Sidekiq::Worker

    def perform(user_id)
      CreateService.call(user_id)
    end
  end
end
