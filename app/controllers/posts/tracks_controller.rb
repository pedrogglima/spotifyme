# frozen_string_literal: true

module Posts
  class TracksController < PrivateApplicationController
    before_action :set_resource, only: %i[destroy]

    def destroy
      @resource.update(deleted: true)

      Feed::DestroyWorker.perform_async(@resource.post.id)

      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    def set_resource
      @resource = Posts::Track.find(params[:id])
    end
  end
end
