# frozen_string_literal: true

class HeaderProfileComponent < ViewComponent::Base
  def initialize(user: nil)
    @user = user
    @title = user ? user.nickname : 'Spotifyme'
    @subtitle = user ? user.username : nil
  end
end
