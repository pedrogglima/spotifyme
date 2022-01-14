# frozen_string_literal: true

class NotificationsController < PrivateApplicationController
  def index
    @pagy, @resources = pagy(Notification.of_like(current_user.id))

    render :index
  end
end
