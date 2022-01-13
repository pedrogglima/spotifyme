# frozen_string_literal: true

class NotificationsController < PrivateApplicationController
  def index
    @pagy, @resources = pagy(current_user.notifications
                                         .order(created_at: :desc)
                                         .limit(30))

    render :index
  end
end
