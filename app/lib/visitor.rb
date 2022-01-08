# frozen_string_literal: true

class Visitor
  extend Forwardable

  def_delegators :@user, :id, :nickname, :username

  def initialize(user)
    @user = user
  end
end
