# frozen_string_literal: true

require 'factory_bot_rails'

USER_1_EMAIL = 'full_1@mail.com'
USER_1_PASSWORD = '123456'

USER_2_EMAIL = 'full_2@mail.com'
USER_2_PASSWORD = '0987654321'

USER_3_EMAIL = 'full_3@mail.com'
USER_3_PASSWORD = 'qwerty123'

USER_4_EMAIL = 'full_4@mail.com'
USER_4_PASSWORD = 'sup3rstr0ng@passw0rd'

MONEY_TRANSACTIONS_COUNT = 35

FactoryBot.create(:user, :with_balance, email: USER_1_EMAIL, password: USER_1_PASSWORD)
FactoryBot.create(:user, :with_balance, email: USER_2_EMAIL, password: USER_2_PASSWORD)
FactoryBot.create(:user, :with_balance, email: USER_3_EMAIL, password: USER_3_PASSWORD)
FactoryBot.create(:user, :with_balance, email: USER_4_EMAIL, password: USER_4_PASSWORD)

User.all.each do |user|
  MONEY_TRANSACTIONS_COUNT.times do
    recepient = (User.all - [user]).sample
    amount_to_transact = rand(100..100000)

    next if user.bank_account.balance < amount_to_transact

    FactoryBot.create(
      :money_transaction,
      sender: user.bank_account,
      recepient: recepient.bank_account,
      amount: amount_to_transact,
      sender_balance_after_transaction: user.bank_account.balance - amount_to_transact,
      recepient_balance_after_transaction: recepient.bank_account.balance + amount_to_transact
    )

    user.bank_account.balance -= amount_to_transact
    user.save

    recepient.bank_account.balance =+ amount_to_transact
    recepient.save
  end
end
