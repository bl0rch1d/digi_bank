# frozen_string_literal: true

module MoneyTransaction
  module Operation
    class Create < ::BaseOperation
      private

      STEPS = %i[
        validate_params
        initialize_model
        make_transaction
        set_result
      ].freeze

      def validate_params(_ctx, contract_class:, params:, **)
        binding.pry
      end
  end
end
