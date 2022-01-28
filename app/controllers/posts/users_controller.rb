# frozen_string_literal: true

module Posts
  class UsersController < PrivateApplicationController
    before_action :set_resource, only: %i[edit update destroy]

    def index
      @posts_user = Posts::User.new

      profile_user_id = current_visited ? current_visited.id : current_user.id

      @pagy, @posts_users = pagy(Posts::User.by_user(profile_user_id))

      respond_to do |format|
        format.html
        format.json do
          render json: {
            entries: render_to_string(partial: 'posts/users/entries', formats: [:html]),
            pagination: view_context.pagy_nav(@pagy)
          }
        end
      end
    end

    def edit
      render :edit, locals: { resource: @resource }
    end

    def create
      @resource = Posts::User.build_with_post(resource_params, current_user)
      @resource.save

      Feed::CreateWorker.perform_async(@resource.post.id) if @resource.valid?

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
      @resource.update(deleted: true)

      @resource.post.destroy

      # Feed::DestroyWorker.perform_async(@resource.post.id)

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
