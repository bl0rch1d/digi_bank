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
FactoryBot.define do
  factory :bank_account do
    balance { 10_000 * 100 }
    association :user
  end
end
