# frozen_string_literal: true

module Posts
  module Users
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[edit update destroy]
      before_action :set_posts_user

      def index
        @resource = Comment.new_with_defaults(posts_user_id: @posts_user)
        @pagy, @resources = pagy(Comment.by_posts_user(@posts_user))

        respond_to do |format|
          format.html
          format.json do
            render json: {
              entries: render_to_string(partial: 'posts/users/comments/comments', formats: [:html]),
              pagination: view_context.pagy_nav(@pagy)
            }
          end
        end
      end

      def edit
        render :edit
      end

      def create
        @resource = Comment.new(resource_params)
        @resource.save
        @new_resource = Comment.new_with_defaults(posts_user_id: @posts_user)

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
          format.turbo_stream do
            render turbo_stream: turbo_stream.remove(@resource)
          end
        end
      end

      def set_comment
        @resource = Comment.find(params[:id])
      end

      def set_posts_user
        @posts_user = params[:user_id]
      end

      def resource_params
        params.require(:comment)
              .permit(:content, :commentable_id, :commentable_type)
              .merge!(user_id: current_user.id)
      end
    end
  end
end
