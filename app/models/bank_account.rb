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

  has_many :sent_transactions, class_name: 'MoneyTransaction',
                               foreign_key: :sender_id,
                               inverse_of: :sender,
                               dependent: :destroy

  has_many :receieved_transactions, class_name: 'MoneyTransaction',
                                    foreign_key: :recepient_id,
                                    inverse_of: :recepient,
                                    dependent: :destroy

  def all_money_transactions
    sent_transactions.or(receieved_transactions).order(created_at: :desc)
  end
end
