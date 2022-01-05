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
      @resource.save

      respond_to do |format|
        format.turbo_stream
      end
    end

    def destroy
      @resource.destroy
      flash[:notice] = 'Deleted with success'

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
