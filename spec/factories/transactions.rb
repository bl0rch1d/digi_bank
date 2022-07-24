# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id         :bigint           not null, primary key
#  from_id    :bigint           not null
#  to_id      :bigint           not null
#  amount     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :transaction do
  end
end
