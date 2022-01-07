# frozen_string_literal: true

module PostType
  module Simples
    class LikesController < ApplicationController
      before_action :set_resource, only: :destroy
      before_action :set_simple

      def create
        @resource = Like.new_with_defaults(simple_id: @simple,
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

      def set_simple
        @simple = params[:simple_id]
      end
    end
  end
end
