# frozen_string_literal: true

class HeaderInviteComponent < ViewComponent::Base
  def initialize(current_visited: nil, status: 'add', deactivated: false)
    @current_visited = current_visited
    @status = status
    @deactivated = deactivated
  end

  def render?
    @current_visited.present?
  end

  def invite_class
    @deactivated ? deactivate_class : activate_class
  end

  def activate_class
    'py-1 px-2 text-white border rounded-full z-0'
  end

  def deactivate_class
    'py-1 px-2 text-white border rounded-full z-0 opacity-50 cursor-not-allowed'
  end
end
