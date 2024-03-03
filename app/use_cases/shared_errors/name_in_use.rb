# frozen_string_literal: true

# SharedErrors
module SharedErrors
  # NameInUse
  class NameInUse < StandardError
    def initialize(name)
      super("The name #{name} is already in use!")
    end
  end
end
