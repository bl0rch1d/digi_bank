# frozen_string_literal: true

describe BankAccountsController, type: :controller do
  let(:user) { create(:user) }

  describe '#show' do
    before do
      sign_in(user)

      get(:show)
    end

    it 'returns a 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders bank_account' do
      expect(response).to render_template('bank_accounts/show')
    end

    it 'assigns decorated bank account' do
      expect(assigns(:operation_result)[:bank_account]).to be_a(BankAccountDecorator)
    end

    it 'assigns decorated money transactions' do
      expect(assigns(:operation_result)[:money_transactions]).to be_a(Draper::CollectionDecorator)
    end
  end
end
