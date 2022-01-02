# frozen_string_literal: true

User.all.each do |user|
  followings = User.where.not(id: user.id)

  followings.each do |following|
    case (rand * 100)
    when 0..50
      FollowInvitation.create!(
        follower: user,
        following: following,
        status: :accepted
      )
    when 51..85
      FollowInvitation.create!(
        follower: user,
        following: following,
        status: :pending
      )
    when 86..92
      FollowInvitation.create!(
        follower: user,
        following: following,
        status: :rejected
      )
    when 93..97
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
