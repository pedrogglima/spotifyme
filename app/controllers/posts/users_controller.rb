# frozen_string_literal: true

module Posts
  class UsersController < PrivateApplicationController
    before_action :set_resource, only: %i[edit update destroy]

    def edit
      render :edit, locals: { resource: @resource }
    end

    def create
      @resource = Posts::User.build_with_post(resource_params, current_user)
      @resource.save

      respond_to do |format|
        format.turbo_stream
      end
    end

    def update
      @resource.update(resource_params)

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
      @resource = Posts::User.find(params[:id])
    end

    def resource_params
      params.require(:posts_user).permit(:content)
    end
  end
end
