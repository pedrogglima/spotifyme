# frozen_string_literal: true

module Track
  class CreateWorker < BaseWorker
    include Sidekiq::Worker

    def perform(user_id, user_uid)
      CreateService.call(user_id, user_uid)
    end
  end
end
