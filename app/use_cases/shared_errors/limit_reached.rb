# frozen_string_literal: true

module SharedErrors
  # LimitReatched
  class LimitReached < StandardError
    def initialize(message = 'Customer limit reached')
      super(message)
    end
  end
end
