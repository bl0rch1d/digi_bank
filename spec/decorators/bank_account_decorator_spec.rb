# frozen_string_literal: true

describe BankAccountDecorator do
  subject(:bank_account) { create(:bank_account).decorate }

  describe '#usd_balance' do
    let(:expected_result) { "#{bank_account.balance / 100.0} $" }

    it 'returns decorated balance' do
      expect(bank_account.usd_balance).to eq(expected_result)
    end
  end
end
