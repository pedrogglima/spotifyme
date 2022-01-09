# frozen_string_literal: true

class SettingsController < PrivateApplicationController
  before_action :set_resource

  def show; end

  def update
    @resource.update(resource_params)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_resource
    @resource = current_user
  end

  def resource_params
    params.require(:user).permit(:avatar, :nickname, :privated_profile)
  end
end
