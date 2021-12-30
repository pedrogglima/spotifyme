# frozen_string_literal: true

class PrivateApplicationController < ApplicationController
  before_action :authenticate_user!
end
