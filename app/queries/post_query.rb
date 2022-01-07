# frozen_string_literal: true

module PostQuery
  def by_user(user_id)
    select(stringify_feeds)
      .joins("LEFT JOIN post_type_simples AS simples ON posts.postable_type = 'PostType::Simple' AND posts.postable_id = simples.id")
      .joins("LEFT JOIN likes AS likes ON likes.likeable_type = 'PostType::Simple' AND likes.likeable_id = simples.id AND likes.user_id = #{user_id}")
      .joins(:user)
      .where(user_id: user_id)
      .order(created_at: :desc)
  end

  def stringify_feeds
    "
      posts.id,
      posts.postable_type,
      posts.postable_id,
      posts.created_at,
      simples.id as simple_id,
      simples.content as simple_content,
      simples.counter_likeable as simple_counter_likeable,
      users.id as user_id,
      users.uid as user_name,
      users.nickname as user_nickname,
      likes.id as like_id
    ".squish.freeze
  end
end
