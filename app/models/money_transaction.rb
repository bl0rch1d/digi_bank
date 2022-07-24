# frozen_string_literal: true

# == Schema Information
#
# Table name: money_transactions
#
#  id         :bigint           not null, primary key
#  from_id    :bigint           not null
#  to_id      :bigint           not null
#  amount     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MoneyTransaction < ApplicationRecord
  belongs_to :from, class_name: 'BankAccount'
  belongs_to :to, class_name: 'BankAccount'
end
