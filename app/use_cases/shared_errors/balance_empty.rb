# frozen_string_literal: true

module SharedErrors
  # BalanceEmpty
  class BalanceEmpty < StandardError
    def initialize(message = 'Cannot delete customer with balance')
      super(message)
    end
  end
end
