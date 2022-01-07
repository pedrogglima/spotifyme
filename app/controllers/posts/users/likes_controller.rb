# frozen_string_literal: true

module Posts
  module Users
    class LikesController < PrivateApplicationController
      before_action :set_resource, only: :destroy
      before_action :set_posts_user

      def create
        @resource = Like.new_with_defaults(posts_user_id: @posts_user,
                                               user_id: current_user.id)
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

      def set_resource
        @resource = Like.find(params[:id])
      end

      def set_posts_user
        @posts_user = params[:user_id]
      end
    end
  end
end
