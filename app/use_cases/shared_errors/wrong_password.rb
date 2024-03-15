# frozen_string_literal: true

module SharedErrors
  # WrongPassword
  class WrongPassword < StandardError
    def initialize(message = 'Wrong password!')
      super(message)
    end
  end
end
