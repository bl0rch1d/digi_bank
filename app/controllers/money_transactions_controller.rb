# frozen_string_literal: true

class MoneyTransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contract = DigiBank::MoneyTransaction::Contract::Create.new
  end

  def create
    result = call_create_operation

    if result[:success?]
      redirect_to root_path, notice: I18n.t('money_transaction.money_sent')
    else
      @contract = result[:contract]

      render 'money_transactions/new'
    end
  end

  private

  def permitted_create_params
    params.require(:money_transaction).permit(:recepient_email, :amount_in_cents)
  end

  def call_create_operation
    DigiBank::MoneyTransaction::Operation::Create.call(
      contract_class: DigiBank::MoneyTransaction::Contract::Create,
      current_user:,
      params: permitted_create_params
    )
  end
end
