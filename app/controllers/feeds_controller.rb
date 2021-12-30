# frozen_string_literal: true

class FeedsController < PrivateApplicationController
  before_action :set_current_user_feed

  def index
    @pagy, @feeds = pagy(Feed.by_user(params[:user_id]), items: 10)
  end

  private

  def set_current_user_feed
    @current_user_feed = User.find(params[:user_id])
  end
end
