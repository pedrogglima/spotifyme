# frozen_string_literal: true

module Posts
  class UsersController < PrivateApplicationController
    before_action :set_posts_user, only: %i[edit update destroy]

    def edit; end

    def update
      respond_to do |format|
        if @resource.update(resource_params)
          format.html { redirect_to profile_path, notice: 'Post was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    def create
      @resource = Posts::User.build_with_post(resource_params, current_user)
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

    def set_posts_user
      @resource = Posts::User.find(params[:id])
    end

    def resource_params
      params.require(:posts_user).permit(:content)
    end
  end
end
