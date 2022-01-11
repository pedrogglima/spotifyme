# frozen_string_literal: true

class HomeController < PrivateApplicationController
  before_action :set_visited, only: %i[profile]
  before_action :set_settings, only: %i[settings]

  def profile
    @post = Posts::User.new

    profile_user_id = current_visited ? current_visited.id : current_user.id

    @pagy, @posts = pagy(Post.by_user(profile_user_id))

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

  def settings; end

  def search; end

  private

  def set_visited
    @visited = User.find(params[:user_id]) if params[:user_id].present? &&
                                              params[:user_id].to_i != current_user.id
  end

  def set_settings
    @settings = current_user
  end
end
