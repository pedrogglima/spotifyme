# frozen_string_literal: true

class LikesCounterComponent < ViewComponent::Base
  def initialize(counter:, style: "h-5 w-5")
    @counter = counter
    @style = style
  end

  def render?
    @counter.positive?
  end

  def gte_three
    @counter >= 3
  end

  def eq_two
    @counter == 2
  end

  def eq_one
    @counter == 1
  end

  def display_count
    @counter.to_s
  end
end
