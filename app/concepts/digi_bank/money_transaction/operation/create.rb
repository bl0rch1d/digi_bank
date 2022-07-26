# frozen_string_literal: true

module DigiBank
  module MoneyTransaction
    module Operation
      class Create < ::BaseOperation
        private

        STEPS = %i[
          validate_params
          fetch_recepient_bank_account
          convert_amount_to_transact
          initialize_model
          populate_money_transaction
          update_sender
          update_recepient
          persist
          set_operation_result
        ].freeze

        def validate_params(ctx, current_user:, contract_class:, params:, **)
          ctx[:contract] = contract_class.new(params.merge(sender: current_user))
          ctx[:contract].validate

          raise ::Errors::ValidationFailed, ctx[:contract].errors.messages unless ctx[:contract].valid?
        end

        def fetch_recepient_bank_account(ctx, params:, **)
          ctx[:recepient] = ::User
                            .includes(:bank_account)
                            .find_by(email: params[:recepient_email])
                            .bank_account
        end

        def convert_amount_to_transact(ctx, params:, **)
          ctx[:amount_to_transact] = params[:amount_in_cents].to_i
        end

        def initialize_model(ctx, current_user:, **)
          ctx[:model] = current_user.bank_account.sent_transactions.new
        end

        def populate_money_transaction(ctx, model:, current_user:, amount_to_transact:, **)
          model.sender_id                             = current_user.bank_account.id
          model.recepient_id                          = ctx[:recepient].id
          model.amount                                = amount_to_transact
          model.sender_balance_after_transaction      = current_user.bank_account.balance - amount_to_transact
          model.recepient_balance_after_transaction   = ctx[:recepient].balance + amount_to_transact
        end

        def update_sender(_ctx, params:, current_user:, **)
          current_user.bank_account.balance -= params[:amount_in_cents].to_i
        end

        def update_recepient(_ctx, params:, recepient:, **)
          recepient.balance += params[:amount_in_cents].to_i
        end

        def persist(_ctx, model:, recepient:, current_user:, **)
          ::ActiveRecord::Base.transaction do
            model.save!
            recepient.save!
            current_user.bank_account.save!
          end
        end

        def set_operation_result(ctx, model:, **)
          ctx[:operation_result] = {
            model:
          }
        end
      end
    end
  end
end
