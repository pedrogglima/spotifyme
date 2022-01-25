# frozen_string_literal: true

module Posts
  class TracksController < PrivateApplicationController
    before_action :set_resource, only: %i[destroy]

    def destroy
      @resource.destroy

      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    def set_resource
      @resource = Posts::User.find(params[:id])
    end
  end
end
