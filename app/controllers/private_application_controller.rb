# frozen_string_literal: true

class PrivateApplicationController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :set_visited_if

  def set_visited_if
    @visited = User.find(params[:user_id]) if params[:user_id].present? &&
                                              params[:user_id].to_i != current_user.id
  end

  def current_visited
    @visited
  end

  def current_user_profile?
    current_visited.nil? ? true : false
  end
  helper_method :current_user_profile?, :current_visited
end
