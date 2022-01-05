# frozen_string_literal: true

module FlashMessageHelper
  def classes_for_flash(key)
    case key.to_sym
    when :notice
    end
    'bg-teal-100'
  end
end
