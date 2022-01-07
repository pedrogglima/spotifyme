# frozen_string_literal: true

class FollowInvitationsController < PrivateApplicationController
  def index
    @pagy, @invitations = pagy(
      FollowInvitation.invitations(current_user.id, :pending)
    )
  end

  def update
    @resource = FollowInvitation.find(params[:id])
    @resource.update(resource_params)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def resource_params
    params.require(:follow_invitation).permit(:status)
  end
end
