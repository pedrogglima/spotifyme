# frozen_string_literal: true

module Track
  class SchedulerService < ApplicationService
    def call
      active_users = ::User.actives_in_last_hour

      active_users.each do |user|
        CreateService.call(user.id)
      end
    end
  end
end
