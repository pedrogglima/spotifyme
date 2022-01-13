# frozen_string_literal: true

notifications_per_user = rand(30..90)

User.all.each do |user|
  notifications_per_user.times do
    content_size = [30, 80, 150].sample

    case (rand * 100)
    when 0..75
      post = Post.all.sample

      Notification.create(
        destinatary: post.user,
        notificable: ::Notifications::OfLike.create(
          post: post,
          content: Faker::Lorem.paragraph_by_chars(number: content_size, supplemental: false)
        )
      )
    when 76..100
      Notification.create(
        destinatary: user,
        notificable: ::Notifications::OfInvite.create(
          content: Faker::Lorem.paragraph_by_chars(number: content_size, supplemental: false)
        )
      )
    end
  end
end
