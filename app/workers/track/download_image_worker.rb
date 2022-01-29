# frozen_string_literal: true

module Track
  class DownloadImageWorker < BaseWorker
    include Sidekiq::Worker

    def perform(track_id)
      DownloadImageService.call(track_id)
    end
  end
end
