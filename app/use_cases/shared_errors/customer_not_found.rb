# frozen_string_literal: true

module SharedErrors
  # CustomerNotFound
  class CustomerNotFound < ActiveRecord::RecordNotFound
    def initialize(message = 'Customer not found')
      super(message)
    end
  end
end
