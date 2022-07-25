# frozen_string_literal: true

describe DigiBank::MoneyTransaction::Contract::Create do
  subject(:contract) { described_class.new(contract_params) }

  let(:current_user) do
    user = create(:user)

    user.bank_account.update(balance: User::STARTER_BALANCE)

    user
  end
  let(:recepient) { create(:user) }
  let(:contract_params) do
    {
      sender: current_user,
      **params
    }
  end

  describe 'SUCCESS' do
    let(:params) do
      {
        recepient_email: recepient.email,
        amount_in_cents: 1000
      }
    end

    it 'successfully validates params' do
      expect(contract).to be_valid
    end
  end

  describe 'FAILURE' do
    describe '#recepient_email' do
      let(:amount_in_cents) { 1000 }

      context 'when absent' do
        let(:params) { { amount_in_cents: } }
        let(:expected_messages) do
          {
            recepient_email: [
              I18n.t('errors.messages.blank'),
              I18n.t('errors.messages.invalid'),
              I18n.t('validation_errors.user_does_not_exists')
            ]
          }
        end

        it_behaves_like 'invalid contract examples'
      end

      context 'when invalid format' do
        let(:params) do
          {
            amount_in_cents:,
            recepient_email: '123'
          }
        end
        let(:expected_messages) do
          {
            recepient_email: [
              I18n.t('errors.messages.invalid'),
              I18n.t('validation_errors.user_does_not_exists')
            ]
          }
        end

        it_behaves_like 'invalid contract examples'
      end

      context 'when recepient does not exist' do
        let(:params) do
          {
            amount_in_cents:,
            recepient_email: 'user_does_not_exists@mail.com'
          }
        end
        let(:expected_messages) do
          {
            recepient_email: [
              I18n.t('validation_errors.user_does_not_exists')
            ]
          }
        end

        it_behaves_like 'invalid contract examples'
      end
    end

    describe '#amount_in_cents' do
      let(:recepient_email) { recepient.email }

      context 'when absent' do
        let(:params) { { recepient_email: } }
        let(:expected_messages) do
          {
            amount_in_cents: [
              I18n.t('errors.messages.blank'),
              I18n.t('errors.messages.not_a_number')
            ]
          }
        end

        it_behaves_like 'invalid contract examples'
      end

      context 'when not a number' do
        let(:params) do
          {
            recepient_email:,
            amount_in_cents: 'not a number'
          }
        end
        let(:expected_messages) do
          {
            amount_in_cents: [
              I18n.t('errors.messages.not_a_number')
            ]
          }
        end

        it_behaves_like 'invalid contract examples'
      end

      context 'when negative' do
        let(:params) do
          {
            recepient_email:,
            amount_in_cents: -123
          }
        end
        let(:expected_messages) do
          {
            amount_in_cents: [
              I18n.t('errors.messages.greater_than', count: 0)
            ]
          }
        end

        it_behaves_like 'invalid contract examples'
      end

      context 'when not enough money' do
        let(:params) do
          {
            recepient_email:,
            amount_in_cents: current_user.bank_account.balance + 100
          }
        end
        let(:expected_messages) do
          {
            amount_in_cents: [
              I18n.t('validation_errors.not_enough_money')
            ]
          }
        end

        it_behaves_like 'invalid contract examples'
      end
    end
  end
end
