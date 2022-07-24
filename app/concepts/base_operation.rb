# frozen_string_literal: true

class BaseOperation
  class << self
    def call(**params)
      build_ctx(params)

      initialize_operation
      run_operation
      build_result
    end

    private

    def build_ctx(params)
      @ctx = {
        operation_result: nil,
        exception: nil,
        exception_message: nil,
        **params
      }
    end

    def initialize_operation
      @operation = new
      @operation_steps = @operation.class::STEPS
    end

    def run_operation
      @operation_steps.each { |step| @operation.method(step).call(@ctx, **@ctx) }
    rescue StandardError => exception
      @ctx[:exception] = exception
      @ctx[:exception_message] = exception.message
    end

    def build_result
      {
        operation: @operation,
        success?: @ctx[:exception].blank?,
        failure?: @ctx[:exception].present?,
        errors: @ctx[:errors],
        result: @ctx[:operation_result],
        **@ctx
      }
    end
  end
end
