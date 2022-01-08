# frozen_string_literal: true

default_password = '123456'
provider = 'spotify'

User.create!(
  email: 'pedrogglima@gmail.com',
  password: default_password,
  password_confirmation: default_password,
  nickname: 'pedrogomes',
  provider: provider,
  uid: 'peedrogomes'
)

users = 30

users.times do |index|
  unique_name = "#{Faker::Name.unique.name}#{index}"
  unique_email = "#{Faker::Internet.unique.email}#{index}"

  User.create!(
    email: unique_email,
    password: default_password,
    password_confirmation: default_password,
    nickname: unique_name,
    provider: provider,
    uid: unique_name
  )
end
