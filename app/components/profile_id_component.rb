# frozen_string_literal: true

class ProfileIdComponent < ViewComponent::Base
  def initialize(nickname:, username:, informative: nil)
    @nickname = nickname
    @username = username
    @informative = informative
  end
end
