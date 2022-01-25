# frozen_string_literal: true

posts_per_user = rand(30..70)

User.all.each do |user|
  posts_per_user.times do
    resource_params = { content: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    Posts::User.build_with_post(resource_params, user).save!

    resource_params = {
      name: Faker::Music.album,
      played_at: Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now),
      duration_ms: Faker::Number.number(digits: 6),
      popularity: Faker::Number.number(digits: 2),
      track_url: Faker::Internet.url,
      album_name: Faker::Music.album,
      album_url: Faker::Internet.url,
      artists_name: Faker::Music::RockBand.name,
      artists_url: Faker::Internet.url
    }

    track = Posts::Track.build_with_post(resource_params, user)

    next unless [true, false].sample

    track_sample = Random.rand(1..5)

    track.image = File.open(
      Rails.root.join(
        'app',
        'assets',
        'images',
        'tracks',
        "example-#{track_sample}-track.jpeg"
      ),
      'rb'
    )

    track.save!
  end
end
