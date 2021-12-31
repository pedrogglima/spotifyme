# frozen_string_literal: true

class FollowInvitationsController < PrivateApplicationController
  def index
    @pagy, @invitations = pagy(
      FollowInvitation.invitations(current_user.id, :pending),
      items: 10
    )
  end

  def update
    @resource = FollowInvitation.find(params[:id])

    respond_to do |format|
      if @resource.update(resource_params)
      end
      format.turbo_stream do
        # TODO: check for a better return value
        render turbo_stream: ''
      end
    end
  end

  def resource_params
    params.require(:follow_invitation).permit(:status)
  end
end
