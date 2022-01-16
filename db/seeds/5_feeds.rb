# frozen_string_literal: true

User.all.each do |user|
  user_posts = user.posts.sample(rand(1..3))
  invitations = FollowInvitation.where(follower: user, status: :accepted)

  invitations.each do |invitation|
    user_posts.each do |post|
      case (rand * 100)
      when 0..85
        Feed.create!(
          user: invitation.following,
          post: post,
          visiable: true
        )
      when 86..100
        Feed.create!(
          user: invitation.following,
          post: post,
          visiable: false
        )
      end
    end
  end
end
