# frozen_string_literal: true

class User
  class DownloadAvatarWorker < BaseWorker
    include Sidekiq::Worker

    def perform(user_id)
      DownloadAvatarService.call(user_id)
    end
  end
end
