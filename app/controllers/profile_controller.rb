# frozen_string_literal: true

class ProfileController < PrivateApplicationController
  def show
    @post = PostType::Simple.new
    @pagy, @posts = pagy(
      current_user.simple_posts.order('posts.created_at': :desc),
      items: 10
    )

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'post_type/simples/posts', formats: [:html]),
          pagination: view_context.pagy_nav(@pagy)
        }
      end
    end
  end
end
