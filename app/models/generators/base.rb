# frozen_string_literal: true

module Generators
  class Base
    class << self
      def with(params)
        new(params)
      end
    end
  end
end
