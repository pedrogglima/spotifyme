# frozen_string_literal: true

module Generators
  class Base
    class << self
      def with(args)
        new(args)
      end
    end
  end
end
