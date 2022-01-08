# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def current_visitor
    @visitor
  end

  def current_user_profile?
    current_visitor.nil? ? true : false
  end
  helper_method :current_user_profile?, :current_visitor
end
