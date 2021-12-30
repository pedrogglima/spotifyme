# frozen_string_literal: true

User.all.each do |user|
  followings = User.where.not(id: user.id)

  followings.each do |following|
    case (rand * 100)
    when 0..80
      FollowInvitation.create!(
        follower: user,
        following: following,
        status: :accepted
      )
    when 81..90
      FollowInvitation.create!(
        follower: user,
        following: following,
        status: :pending
      )
    when 90..94
      FollowInvitation.create!(
        follower: user,
        following: following,
        status: :rejected
      )
    when 95..97
      FollowInvitation.create!(
        follower: user,
        following: following,
        status: :ignored
      )
    else
      FollowInvitation.create!(
        follower: user,
        following: following,
        status: :blocked
      )
    end
  end
end
