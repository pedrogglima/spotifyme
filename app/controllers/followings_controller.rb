# frozen_string_literal: true

class FollowingsController < PrivateApplicationController
  def index
    @pagy, @followings = pagy(
      FollowInvitation.followings(current_user.id, :accepted)
    )
  end
end
