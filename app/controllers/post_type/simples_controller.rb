# frozen_string_literal: true

module PostType
  class SimplesController < ApplicationController
    def create
      @resource = PostType::Simple.build_with_post(resource_params, current_user)
      respond_to do |format|
        if @resource.save
          format.html { redirect_to profile_path, notice: 'Post was successfully created.' }
        else
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(@resource,
                                                      partial: 'post_type/simples/form',
                                                      locals: { simple: @resource })
          end
        end
      end
    end

    private

    def resource_params
      params.require(:post_type_simple).permit(:content)
    end
  end
end
