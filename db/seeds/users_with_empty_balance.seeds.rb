# frozen_string_literal: true

require 'factory_bot_rails'

USER_1_EMAIL = 'empty_1@mail.com'
USER_1_PASSWORD = '123456'

USER_2_EMAIL = 'empty_2@mail.com'
USER_2_PASSWORD = '0987654321'

USER_3_EMAIL = 'empty_3@mail.com'
USER_3_PASSWORD = 'qwerty123'

FactoryBot.create(:user, email: USER_1_EMAIL, password: USER_1_PASSWORD)
FactoryBot.create(:user, email: USER_2_EMAIL, password: USER_2_PASSWORD)
FactoryBot.create(:user, email: USER_3_EMAIL, password: USER_3_PASSWORD)

BankAccount.update_all(balance: 0)

