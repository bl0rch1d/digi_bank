# frozen_string_literal: true

describe DigiBank::MoneyTransaction::Operation::Create do
  subject(:operation) { described_class.call(**operation_params) }

  let(:current_user) do
    user = create(:user)

    user.bank_account.update(balance: User::STARTER_BALANCE)

    user
  end
  let(:recepient) { create(:user) }
  let(:params) { {} }
  let(:operation_params) do
    {
      contract_class: DigiBank::MoneyTransaction::Contract::Create,
      current_user:,
      params:
    }
  end
  let(:amount_in_cents) { User::STARTER_BALANCE / 4 }

  describe 'SUCCESS' do
    let(:params) do
      {
        recepient_email: recepient.email,
        amount_in_cents:
      }
    end

    let(:expected_sender_balance) { current_user.bank_account.balance - amount_in_cents }
    let(:expected_recepient_balance) { amount_in_cents }

    let!(:expected_transaction_attributes) do
      {
        sender_id: current_user.bank_account.id,
        recepient_id: recepient.bank_account.id,
        amount: amount_in_cents,
        sender_balance_after_transaction: expected_sender_balance,
        recepient_balance_after_transaction: expected_recepient_balance
      }
    end

    it 'creates one money transaction with correct fields' do
      created_model_attributes = operation[:result][:model]
                                 .attributes.except('created_at', 'updated_at', 'id')
                                 .symbolize_keys

      expect(created_model_attributes).to eq expected_transaction_attributes
    end

    it 'creates one money transaction' do
      expect { operation }.to change(MoneyTransaction, :count).by(1)
    end

    it "correctly updates sender's balance" do
      expect { operation }
        .to change { current_user.bank_account.balance }
        .from(User::STARTER_BALANCE)
        .to(User::STARTER_BALANCE - amount_in_cents)
    end

    it "correctly updates recepient's balance" do
      expect { operation }
        .to change { recepient.bank_account.reload.balance }
        .from(0)
        .to(amount_in_cents)
    end
  end

  describe 'FAILURE' do
    context 'when validation fails' do
      let(:params) do
        {
          recepient_email: 'this_user_does_not_exists@mail.com',
          amount_in_cents:
        }
      end

      it 'returns validation error' do
        expect(operation[:exception]).to be_a(Errors::ValidationFailed)
      end

      it_behaves_like 'invalid create money transaction operation examples'
    end

    context 'when transaction fails' do
      let(:params) do
        {
          recepient_email: recepient.email,
          amount_in_cents:
        }
      end

      before do
        allow(current_user.bank_account).to receive(:save!).and_raise(ActiveRecord::StatementInvalid)
      end

      it 'returns validation error' do
        expect(operation[:exception]).to be_a(ActiveRecord::StatementInvalid)
      end

      it_behaves_like 'invalid create money transaction operation examples'
    end
  end
end
