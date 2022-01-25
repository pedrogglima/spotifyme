# frozen_string_literal: true

class LikesHeartComponent < ViewComponent::Base
  def initialize(margin: nil, style: "h-5 w-5")
    @margin = margin
    @style = style
  end
end
