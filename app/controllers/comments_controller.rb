# frozen_string_literal: true

class CommentsController < PrivateApplicationController
  before_action :set_resource, only: %i[edit update destroy]

  def index
    @resource = Comment.new(commentable_id: params[:commentable_id], commentable_type: params[:commentable_type])
    @pagy, @resources = pagy(Comment.by_posts_user(@resource.commentable_type, @resource.commentable_id))

    render :index
  end

  def edit
    render :edit
  end

  def create
    @resource = Comment.new(resource_params)
    @resource.save
    @new_resource = Comment.new(commentable_id: @resource.commentable_id,
                                commentable_type: @resource.commentable_type)

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
      format.turbo_stream
    end
  end

  def set_resource
    @resource = Comment.find(params[:id])
  end

  def resource_params
    params.require(:comment)
          .permit(:content, :commentable_id, :commentable_type)
          .merge!(user_id: current_user.id)
  end
end
