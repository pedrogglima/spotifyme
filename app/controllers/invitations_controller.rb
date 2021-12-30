# frozen_string_literal: true

class InvitationsController < PrivateApplicationController
  def index
    @pagy, @invitations = pagy(
      FollowInvitation.invitations(current_user.id, :pending),
      items: 10
    )
  end
end
