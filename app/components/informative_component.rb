# frozen_string_literal: true

class InformativeComponent < ViewComponent::Base
  def initialize(title:, text: nil)
    @title = title
    @text = text
  end
end
