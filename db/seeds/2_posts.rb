# frozen_string_literal: true

posts_per_user = rand(30..60)

User.all.each do |user|
  posts_per_user.times do
    resource_params = { content: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    PostType::Simple.build_with_post(resource_params, user).save!
  end
end
