# frozen_string_literal: true

class FeedsController < PrivateApplicationController
  before_action :set_current_user_feed

  def index
    @pagy, @feeds = pagy(Feed.by_user(params[:user_id]))
  end

  private

  def set_current_user_feed
    @current_user_feed = if params[:user_id]
                           User.find(params[:user_id])
                         else
                           current_user
                         end
  end
end
