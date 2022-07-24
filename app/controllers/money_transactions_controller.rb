# frozen_string_literal: true

class MoneyTransactionsController < ApplicationController
  before_action :authenticate_user!

  def create
    result = MoneyTransaction::Operation::Create.call(
      contract_class: MoneyTransaction::Contract::Create,
      current_user: current_user,
      params: permitted_create_params
    )
  end

  private

  def permitted_create_params
    params.require(:money_transaction).permit(:recepient_email, :amount_in_cents)
  end
end
