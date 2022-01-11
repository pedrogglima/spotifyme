# frozen_string_literal: true

class InformativeComponent < ViewComponent::Base
  def initialize(title:, text: nil, button: nil)
    @title = title
    @text = text
    @button = button
  end
end
