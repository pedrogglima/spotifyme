# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_visited
    @visited
  end

  def current_user_profile?
    current_visited.nil? ? true : false
  end
  helper_method :current_user_profile?, :current_visited
end
