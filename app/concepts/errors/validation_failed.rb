# frozen_string_literal: true

module Errors
  class ValidationFailed < StandardError
    attr_reader :errors

    def initialize(errors)
      super(I18n.t('validation_errors.validation_failed'))

      @errors = errors
    end
  end
end
