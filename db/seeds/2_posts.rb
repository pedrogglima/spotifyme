# frozen_string_literal: true

posts_per_user = rand(10..15)

User.all.each do |user|
  posts_per_user.times do
    Post.create!(
      user: user,
      postable: PostType::Simple.create!(
        content: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false)
      )
    )
  end
end
