# frozen_string_literal: true

module FollowInvitationQuery
  def invitations(user_id, status)
    select(stringify_invitations)
      .joins(:follower)
      .where(following_id: user_id, status: status)
      .order(created_at: :desc)
  end

  alias followers invitations

  def followings(user_id, status)
    select(stringify_invitations)
      .joins(:following)
      .where(follower_id: user_id, status: status)
      .order(created_at: :desc)
  end

  def stringify_invitations
    "
      follow_invitations.id,
      follow_invitations.follower_id,
      follow_invitations.following_id,
      follow_invitations.status,
      follow_invitations.created_at,
      users.uid as username,
      users.nickname as nickname,
      users.email as email
    ".squish.freeze
  end
end
