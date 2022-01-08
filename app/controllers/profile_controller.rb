# frozen_string_literal: true

class ProfileController < PrivateApplicationController
  before_action :set_visitor

  def show
    @post = Posts::User.new

    profile_user_id = current_visitor ? current_visitor.id : current_user.id

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

  def set_visitor
    @visitor = User.find_visitor(params[:user_id]) if params[:user_id].present? &&
                                                      params[:user_id].to_i != current_user.id
  end
end
