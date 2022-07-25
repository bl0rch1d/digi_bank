# frozen_string_literal: true

# == Schema Information
#
# Table name: money_transactions
#
#  id                                  :bigint           not null, primary key
#  sender_id                           :bigint           not null
#  recepient_id                        :bigint           not null
#  amount                              :bigint           not null
#  sender_balance_after_transaction    :bigint           not null
#  recepient_balance_after_transaction :bigint           not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
FactoryBot.define do
  factory :money_transaction do
    sender { create(:bank_account) }
    recepient { create(:bank_account) }
    amount { rand(1000.100000000) }

    after :build do |transaction, _evaluator|
      transaction.sender.balance -= transaction.amount
      transaction.recepient.balance += transaction.amount

      transaction.sender_balance_after_transaction = transaction.sender.balance
      transaction.recepient_balance_after_transaction = transaction.recepient.balance

      transaction.sender.save
      transaction.recepient.save
      transaction.save
    end
  end
end
