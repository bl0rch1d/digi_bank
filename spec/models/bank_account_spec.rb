# == Schema Information
#
# Table name: bank_accounts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
describe BankAccount, type: :model do
  let(:bank_account) { create :bank_account }

  it { expect(subject).to be_a BankAccount }

  describe 'database table' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'indexes' do
    it { should have_db_index(:user_id) }
  end
end
