# frozen_string_literal: true

class ProfileController < PrivateApplicationController
  before_action :set_current_user

  def show
    @post = Posts::User.new
    @pagy, @posts = pagy(Post.by_user(@current_user.id))

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'posts/entries', formats: [:html]),
          pagination: view_context.pagy_nav(@pagy)
        }
      end
    end
  end

  def set_current_user
    @current_user = if params[:user_id]
                      User.find(params[:user_id])
                    else
                      current_user
                    end
  end
end
