# frozen_string_literal: true

describe DigiBank::BankAccount::Operation::Show do
  subject(:operation) { described_class.call(**operation_params) }

  let(:current_user) { create(:user, :with_money_transactions) }
  let(:params) { {} }
  let(:operation_params) do
    {
      current_user:,
      params:
    }
  end

  describe 'decoration' do
    it 'returns decorated bank account' do
      expect(operation[:result][:bank_account]).to be_a(BankAccountDecorator)
    end

    it 'returns decorated collection of money transactions' do
      expect(operation[:result][:money_transactions]).to be_a(Draper::CollectionDecorator)
    end

    it 'returns decorated money transactions' do
      expect(operation[:result][:money_transactions].first).to be_a(MoneyTransactionDecorator)
    end
  end

  describe 'pagination' do
    it 'returns pagy cursor' do
      expect(operation[:result][:pagy_cursor]).to be_a(Pagy)
    end

    it 'returns paginated money transactions' do
      expect(operation[:result][:money_transactions].count).to eq Pagy::DEFAULT[:items]
    end

    it 'returns the first page' do
      expect(operation[:result][:pagy_cursor].page).to eq 1
    end

    context 'when user sends page param' do
      let(:page_number) { 2 }
      let(:params) { { page: page_number } }

      it 'returns money transactions page according to the page param' do
        expect(operation[:result][:pagy_cursor].page).to eq page_number
      end
    end
  end
end
