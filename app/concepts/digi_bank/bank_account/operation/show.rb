# frozen_string_literal: true

module DigiBank
  module BankAccount
    module Operation
      class Show < ::BaseOperation
        private

        include Pagy::Backend

        STEPS = %i[
          fetch_bank_account
          fetch_money_transaction
          decorate_bank_account
          paginate_money_transactions
          decorate_money_transactions
          set_operation_result
        ].freeze

        def fetch_bank_account(ctx, current_user:, **)
          ctx[:bank_account] = current_user.bank_account
        end

        def fetch_money_transaction(ctx, bank_account:, **)
          ctx[:money_transactions] = bank_account.all_money_transactions.includes(:recepient, sender: :user)
        end

        def decorate_bank_account(ctx, bank_account:, **)
          ctx[:decorated_bank_account] = bank_account.decorate
        end

        def paginate_money_transactions(ctx, params:, money_transactions:, **)
          vars = { page: params[Pagy::DEFAULT[:page_param]] || 1 }

          ctx[:pagy_cursor], ctx[:paginated_money_transactions] = pagy(
            money_transactions,
            vars
          )
        end

        def decorate_money_transactions(ctx, current_user:, paginated_money_transactions:, **)
          ctx[:decorated_and_paginated_money_transactions] = paginated_money_transactions.decorate(
            context: { current_user_id: current_user.id }
          )
        end

        def set_operation_result(ctx, decorated_bank_account:, decorated_and_paginated_money_transactions:,
                                 pagy_cursor:, **)
          ctx[:operation_result] = {
            bank_account: decorated_bank_account,
            money_transactions: decorated_and_paginated_money_transactions,
            pagy_cursor:
          }
        end
      end
    end
  end
end
