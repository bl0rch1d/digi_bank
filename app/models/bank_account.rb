# frozen_string_literal: true

# == Schema Information
#
# Table name: bank_accounts
#
#  id         :bigint           not null, primary key
#  balance    :bigint           default(0), not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BankAccount < ApplicationRecord
  belongs_to :user

  has_many :send_transactions, class_name: 'MoneyTransaction',
                               foreign_key: :from_id,
                               inverse_of: :from,
                               dependent: :destroy

  has_many :receieve_transactions, class_name: 'MoneyTransaction',
                                   foreign_key: :to_id,
                                   inverse_of: :to,
                                   dependent: :destroy

  def all_money_transactions
    send_transactions.or(receieve_transactions)
  end
end
