# frozen_string_literal: true

class LikesHeartComponent < ViewComponent::Base
  def initialize(margin: nil)
    @margin = margin
  end
end
