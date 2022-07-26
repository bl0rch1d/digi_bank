# frozen_string_literal: true

class BankAccountDecorator < Draper::Decorator
  delegate_all

  def usd_balance
    "#{in_usd(balance)}$"
  end

  private

  def in_usd(cents)
    cents / 100.0
  end
end
