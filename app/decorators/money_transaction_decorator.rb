# frozen_string_literal: true

class MoneyTransactionDecorator < Draper::Decorator
  delegate_all

  def bootstrap_row_color_class
    current_user_sender? ? 'table-danger' : 'table-success'
  end

  def sender_email
    current_user_sender? ? I18n.t('bank_account.you') : recepient.user.email
  end

  def recepient_email
    current_user_sender? ? recepient.user.email : I18n.t('bank_account.you')
  end

  def transfered_amount
    "#{current_user_sender? ? '-' : '+'} #{in_usd(amount)}$"
  end

  def balance_after_transaction
    value_in_cents = current_user_sender? ? sender_balance_after_transaction : recepient_balance_after_transaction

    "#{in_usd(value_in_cents)}$"
  end

  private

  def current_user_sender?
    sender.user.id == context[:current_user_id]
  end

  def in_usd(cents)
    cents / 100.0
  end
end
