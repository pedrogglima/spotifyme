# frozen_string_literal: true

class HeaderTitleComponent < ViewComponent::Base
  def initialize(title:, subtitle: nil)
    @title = title
    @subtitle = subtitle
  end
end
