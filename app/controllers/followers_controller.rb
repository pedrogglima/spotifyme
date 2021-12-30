# frozen_string_literal: true

class FollowersController < PrivateApplicationController
  def index
    @pagy, @followers = pagy(
      FollowInvitation.followers(current_user.id, :accepted),
      items: 10
    )
  end
end
