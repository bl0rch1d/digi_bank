# == Schema Information
#
# Table name: bank_accounts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BankAccount < ApplicationRecord
  belongs_to :user
end
