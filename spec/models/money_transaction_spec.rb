# frozen_string_literal: true

# == Schema Information
#
# Table name: money_transactions
#
#  id                                  :bigint           not null, primary key
#  sender_id                           :bigint           not null
#  recepient_id                        :bigint           not null
#  amount                              :bigint           not null
#  sender_balance_after_transaction    :bigint           not null
#  recepient_balance_after_transaction :bigint           not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
describe MoneyTransaction, type: :model do
  let(:money_transaction) { create :money_transaction }

  it { expect(money_transaction).to be_a described_class }

  describe 'database table' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:amount).of_type(:integer) }
    it { is_expected.to have_db_column(:sender_balance_after_transaction).of_type(:integer) }
    it { is_expected.to have_db_column(:recepient_balance_after_transaction).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:sender).class_name('BankAccount') }
    it { is_expected.to belong_to(:recepient).class_name('BankAccount') }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:recepient_id) }
    it { is_expected.to have_db_index(:sender_id) }
  end
end
