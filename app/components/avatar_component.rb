# frozen_string_literal: true

class AvatarComponent < ViewComponent::Base
  def initialize(user:, username: 'U', style: 'w-10 h-10')
    @user = normalize_user(user)
    @username = username
    @style = style
  end

  def normalize_user(user)
    user.is_a?(String) ? User.new(avatar_data: user) : user
  end

  def picture?
    @user.present? && @user.is_a?(User) && @user.avatar_data.present?
  end

  def first_letter
    @username.first.upcase
  end
end
