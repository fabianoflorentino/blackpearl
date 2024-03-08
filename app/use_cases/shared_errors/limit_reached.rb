# frozen_string_literal: true

module SharedErrors
  # LimitReatched
  class LimitReached < StandardError
    def initialize(message = 'Customer limit reatched')
      super(message)
    end
  end
end
