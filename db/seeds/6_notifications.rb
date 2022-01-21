# frozen_string_literal: true

notifications_per_user = rand(30..90)

User.all.each do |user|
  notifications_per_user.times do
    case (rand * 100)
    when 0..75
      post = Post.all.sample
      Notifications::OfLike.build_with_notification(
        {
          content: "#{user.username} liked your post",
          post_id: post.id
        },
        post.user_id
      ).save!
    when 76..100
      Notifications::OfInvite.build_with_notification(
        {
          content: "#{user.username} want to follow you"
        },
        user.id
      ).save!
    end
  end
end
