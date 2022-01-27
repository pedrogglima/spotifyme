# frozen_string_literal: true

class HomeController < PrivateApplicationController
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
    profile_user_id = current_visited ? current_visited.id : current_user.id

    @pagy, @posts_tracks = pagy(Posts::Track.by_user(profile_user_id))

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'posts/tracks/entries', formats: [:html]),
          pagination: view_context.pagy_nav(@pagy)
        }
      end
    end
  end

  def search; end

  def settings; end

  private

  def set_settings
    @settings = current_user
  end
end
