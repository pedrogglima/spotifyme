# frozen_string_literal: true

class ProfileController < PrivateApplicationController
  def show
    @pagy, @posts = pagy(
      current_user.simple_posts.order('posts.created_at': :desc),
      items: 10
    )
  end
end
