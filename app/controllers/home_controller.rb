# frozen_string_literal: true

class HomeController < PrivateApplicationController
  before_action :set_visited, only: %i[profile]
  before_action :set_settings, only: %i[settings]

  def feed
    @pagy, @resources = pagy(Feed.by_user(current_user.id))

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'feeds/entries', formats: [:html]),
          pagination: view_context.pagy_nav(@pagy)
        }
      end
    end
  end

  def profile
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

  def search; end

  def settings; end

  private

  def set_visited
    @visited = User.find(params[:user_id]) if params[:user_id].present? &&
                                              params[:user_id].to_i != current_user.id
  end

  def set_settings
    @settings = current_user
  end
end
