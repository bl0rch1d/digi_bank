# frozen_string_literal: true

describe MoneyTransactionsController, type: :controller do
  let(:user) { create(:user, :with_balance) }

  before do
    sign_in(user)

    call_action
  end

  describe '#new' do
    let(:call_action) { get(:new) }

    it 'returns a 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders money transaction form' do
      expect(response).to render_template('money_transactions/new')
    end

    it 'assigns contract' do
      expect(assigns(:contract)).to be_a(DigiBank::MoneyTransaction::Contract::Create)
    end
  end

  describe '#create' do
    let(:call_action) { post(:create, params:) }

    context 'when success' do
      let(:params) do
        {
          money_transaction: {
            recepient_email: user.email,
            amount_in_cents: 100
          }
        }
      end

      it 'returns a 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to bank_account' do
        expect(response).to redirect_to(root_path)
      end

      it 'renders flash notice' do
        expect(request.flash[:notice]).to eq(I18n.t('money_transaction.money_sent'))
      end
    end

    context 'when failure' do
      let(:params) do
        {
          money_transaction: {
            recepient_email: user.email,
            amount_in_cents: -100
          }
        }
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders new money transaction form' do
        expect(response).to render_template('money_transactions/new')
      end

      it 'assigns contract' do
        expect(assigns(:contract)).to be_a(DigiBank::MoneyTransaction::Contract::Create)
      end
    end
  end
end
