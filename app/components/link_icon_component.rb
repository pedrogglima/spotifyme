# frozen_string_literal: true

class LinkIconComponent < ViewComponent::Base
  def initialize(url:, title:, icon:)
    @url = url
    @title = title
    @icon = icon
  end

  def render_icon
    select_icon
  end

  def select_icon
    case @icon
    when 'search'
      "<svg xmlns='http://www.w3.org/2000/svg' class='-ml-1 mr-2 h-5 w-5' viewBox='0 0 20 20' fill='currentColor'>
        <path fill-rule='evenodd' d='M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z' clip-rule='evenodd' />
      </svg>"
    when 'plus'
      "<svg class='-ml-1 mr-2 h-5 w-5' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 20 20' fill='currentColor' aria-hidden='true'>
        <path fill-rule='evenodd' d='M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z' clip-rule='evenodd' />
      </svg>"
    end
  end
end
