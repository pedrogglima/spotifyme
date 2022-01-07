# frozen_string_literal: true

class LikesController < PrivateApplicationController
  before_action :set_resource, only: :destroy

  def create
    @resource = Like.new(resource_params)
    @resource.save

    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @resource.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_resource
    @resource = Like.find(params[:id])
  end

  def resource_params
    params.require(:like)
          .permit(:likeable_type, :likeable_id)
          .merge(user_id: current_user.id)
  end
end
