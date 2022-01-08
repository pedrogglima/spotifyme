# frozen_string_literal: true

class FeedsController < PrivateApplicationController
  def index
    @pagy, @feeds = pagy(Feed.by_user(current_user.id))
  end
end
