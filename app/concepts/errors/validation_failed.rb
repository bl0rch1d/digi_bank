# frozen_string_literal: true

module Errors
  class ValidationFailed < StandardError
    attr_reader :errors

    def initialize(errors)
      super('Validation failed')

      @errors = errors
    end
  end
end
