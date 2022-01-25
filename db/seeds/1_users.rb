# frozen_string_literal: true

default_password = '123456'
provider = 'spotify'

u = User.create!(
  email: 'pedrogglima@gmail.com',
  password: default_password,
  password_confirmation: default_password,
  nickname: 'pedrogomes',
  provider: provider,
  uid: 'peedrogomes',
  bio: Faker::Lorem.paragraph_by_chars(number: rand(0..150), supplemental: false)
)

u.avatar = File.open(Rails.root.join('app', 'assets', 'images', 'avatars', 'example-0-avatar.jpeg'), 'rb')
u.save!

users = 15

users.times do |index|
  unique_name = "#{Faker::Name.unique.name}#{index}"
  unique_email = "#{Faker::Internet.unique.email}#{index}"

  u = User.create!(
    email: unique_email,
    password: default_password,
    password_confirmation: default_password,
    nickname: unique_name,
    provider: provider,
    uid: unique_name,
    bio: Faker::Lorem.paragraph_by_chars(number: rand(0..150), supplemental: false)
  )

  next unless [true, false].sample

  avatar_sample = Random.rand(1..5)

  u.avatar = File.open(Rails.root.join('app', 'assets', 'images', 'avatars', "example-#{avatar_sample}-avatar.jpeg"),
                       'rb')
  u.save!
end
