# frozen_string_literal: true

User.all.each do |user|
  followings = User.where.not(id: user.id)

  followings.each do |following|
    case (rand * 100)
    when 0..50
      f = FollowInvitation.create!(
        follower: user,
        following: following,
        status: :accepted
      )

      f.accepted!
    when 51..85
      f = FollowInvitation.create!(
        follower: user,
        following: following,
        status: :pending
      )
      f.pending!
    when 86..92
      f = FollowInvitation.create!(
        follower: user,
        following: following,
        status: :rejected
      )
      f.rejected!
    when 93..97
      f = FollowInvitation.create!(
        follower: user,
        following: following,
        status: :ignored
      )
      f.ignored!
    else
      f = FollowInvitation.create!(
        follower: user,
        following: following,
        status: :blocked
      )
      f.blocked!
    end
  end
end
