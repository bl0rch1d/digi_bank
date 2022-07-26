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
class MoneyTransaction < ApplicationRecord
  belongs_to :sender, class_name: 'BankAccount'
  belongs_to :recepient, class_name: 'BankAccount'
end
