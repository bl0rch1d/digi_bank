# frozen_string_literal: true

class MoneyTransactionDecorator < Draper::Decorator
  delegate_all

  def bootstrap_row_color_class
    current_user_sender? ? 'table-danger' : 'table-success'
  end

  def from_email
    current_user_sender? ? 'you' : to.user.email
  end

  def to_email
    current_user_sender? ? from.user.email : 'you'
  end

  def transfered_amount
    "#{current_user_sender? ? '-' : '+'} #{in_usd(amount)}$"
  end

  def balance_after_transaction
    value_in_cents = current_user_sender? ? from_amount_after_transaction : to_amount_after_transaction

    "#{in_usd(value_in_cents)}$"
  end

  private

  def current_user_sender?
    from.user.id == context[:current_user_id]
  end

  def in_usd(cents)
    cents / 100.0
  end
end
