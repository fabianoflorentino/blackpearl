# frozen_string_literal: true

module SharedErrors
  # LimitReatched
  class LimitReached < ActiveRecord::StatementInvalid
    def initialize(message = 'Customer limit reached')
      super(message)
    end
  end
end
