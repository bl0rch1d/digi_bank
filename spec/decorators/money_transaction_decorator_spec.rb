# frozen_string_literal: true

describe MoneyTransactionDecorator do
  subject(:money_transaction) do
    create(:money_transaction, sender_id: sender.bank_account.id, recepient_id: recepient.bank_account.id)
      .decorate(context: { current_user_id: sender.id })
  end

  let(:sender) { create(:user) }
  let(:recepient) { create(:user) }

  describe '#bootstrap_row_color_class' do
    context 'when current user is sender' do
      let(:expected_result) { 'table-danger' }

      it 'returns decorated balance' do
        expect(money_transaction.bootstrap_row_color_class).to eq(expected_result)
      end
    end

    context 'when current user is recepient' do
      let(:expected_result) { 'table-success' }

      before { money_transaction.update(sender_id: recepient.bank_account.id) }

      it 'returns decorated balance' do
        expect(money_transaction.bootstrap_row_color_class).to eq(expected_result)
      end
    end
  end

  describe '#sender_email' do
    context 'when current user is sender' do
      let(:expected_result) { I18n.t('bank_account.you') }

      it 'returns decorated balance' do
        expect(money_transaction.sender_email).to eq(expected_result)
      end
    end

    context 'when current user is recepient' do
      let(:expected_result) { recepient.email }

      before { money_transaction.update(sender_id: recepient.bank_account.id) }

      it 'returns decorated balance' do
        expect(money_transaction.sender_email).to eq(expected_result)
      end
    end
  end

  describe '#recepient_email' do
    context 'when current user is sender' do
      let(:expected_result) { recepient.email }

      it 'returns decorated balance' do
        expect(money_transaction.recepient_email).to eq(expected_result)
      end
    end

    context 'when current user is recepient' do
      let(:expected_result) { I18n.t('bank_account.you') }

      before { money_transaction.update(sender_id: recepient.bank_account.id) }

      it 'returns decorated balance' do
        expect(money_transaction.recepient_email).to eq(expected_result)
      end
    end
  end

  describe '#transfered_amount' do
    context 'when current user is sender' do
      let(:expected_result) { "- #{money_transaction.amount / 100.0}$" }

      it 'returns decorated balance' do
        expect(money_transaction.transfered_amount).to eq(expected_result)
      end
    end

    context 'when current user is recepient' do
      let(:expected_result) { "+ #{money_transaction.amount / 100.0}$" }

      before { money_transaction.update(sender_id: recepient.bank_account.id) }

      it 'returns decorated balance' do
        expect(money_transaction.transfered_amount).to eq(expected_result)
      end
    end
  end

  describe '#balance_after_transaction' do
    context 'when current user is sender' do
      let(:expected_result) { "#{money_transaction.sender_balance_after_transaction / 100.0}$" }

      it 'returns decorated balance' do
        expect(money_transaction.balance_after_transaction).to eq(expected_result)
      end
    end

    context 'when current user is recepient' do
      let(:expected_result) { "#{money_transaction.recepient_balance_after_transaction / 100.0}$" }

      before { money_transaction.update(sender_id: recepient.bank_account.id) }

      it 'returns decorated balance' do
        expect(money_transaction.balance_after_transaction).to eq(expected_result)
      end
    end
  end
end
