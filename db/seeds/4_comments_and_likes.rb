# frozen_string_literal: true

comments_per_post = rand(0..15)
likes_per_post = rand(0..20)

PostType::Simple.all.each do |post|
  comments_per_post.times do
    Comment.create!(
      commentable: post,
      user: User.all.sample,
      content: Faker::Lorem.paragraph_by_chars(number: 250, supplemental: false),
      like_count: rand(0..50)
    )
  end

  likes_per_post.times do |_i|
    PostLike.create!(
      likeable: post,
      user: User.all.sample
    )
  end
end
