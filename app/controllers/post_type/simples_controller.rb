# frozen_string_literal: true

module PostType
  class SimplesController < PrivateApplicationController
    before_action :set_simple, only: %i[edit update destroy]

    def edit; end

    def update
      respond_to do |format|
        if @resource.update(resource_params)
          format.html { redirect_to profile_path, notice: 'Post was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

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

    def destroy
      @resource.destroy

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(@resource)
        end
      end
    end

    private

    def set_simple
      @resource = PostType::Simple.find(params[:id])
    end

    def resource_params
      params.require(:post_type_simple).permit(:content)
    end
  end
end
