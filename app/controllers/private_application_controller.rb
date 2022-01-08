# frozen_string_literal: true

class PrivateApplicationController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!
end
