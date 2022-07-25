# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string           not null
#  encrypted_password  :string           not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { SecureRandom.hex(Devise.password_length.min) }

    trait :with_balance do
      after :create do |user, _evaluator|
        user.bank_account.balance = User::STARTER_BALANCE
        user.bank_account.save
      end
    end

    trait :with_money_transactions do
      after :create do |user, _evaluator|
        recepient_bank_account = create(:user).bank_account
        sender_bank_account = user.bank_account
        amount_to_transact = rand(100..10_000)

        15.times do
          create(
            :money_transaction,
            recepient: recepient_bank_account,
            sender: sender_bank_account,
            amount: amount_to_transact,
            sender_balance_after_transaction: sender_bank_account.balance - amount_to_transact,
            recepient_balance_after_transaction: recepient_bank_account.balance + amount_to_transact
          )

          recepient_bank_account.balance += amount_to_transact
          recepient_bank_account.save

          sender_bank_account.balance -= amount_to_transact
          sender_bank_account.save
        end
      end
    end
  end
end
