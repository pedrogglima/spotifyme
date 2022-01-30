# frozen_string_literal: true

module Track
  class SchedulerWorker < BaseWorker
    include Sidekiq::Worker

    def perform
      SchedulerService.call
    end
  end
end
