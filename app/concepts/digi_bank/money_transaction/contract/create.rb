# frozen_string_literal: true

module DigiBank
  module MoneyTransaction
    module Contract
      class Create < ::BaseContract
        attr_accessor :sender, :recepient_email, :amount_in_cents

        validates :recepient_email, presence: true
        validates :recepient_email, format: { with: User::EMAIL_REGEX }
        validate :recepient_exists?

        validates :amount_in_cents, presence: true
        validates :amount_in_cents, numericality: { only_integer: true, greater_than: 0 }
        validate :enough_money?

        private

        def enough_money?
          return if sender.bank_account.balance - amount_in_cents.to_i >= 0

          errors.add(:amount_in_cents, I18n.t('validation_errors.not_enough_money'))
        end

        def recepient_exists?
          return if ::User.exists?(email: recepient_email)

          errors.add(:recepient_email, I18n.t('validation_errors.user_does_not_exists'))
        end
      end
    end
  end
end
