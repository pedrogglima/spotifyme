# frozen_string_literal: true

comments_per_post = rand(0..15)
likes_per_post = rand(0..20)

Posts::User.all.each do |post|
  comments_per_post.times do
    Comment.create!(
      commentable: post,
      user: User.all.sample,
      content: Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false)
    )
  end

  likes_per_post.times do |_i|
    Like.create!(
      likeable: post,
      follower: User.all.sample
    )
  end
end
