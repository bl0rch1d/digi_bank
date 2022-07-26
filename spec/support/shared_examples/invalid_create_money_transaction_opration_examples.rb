# frozen_string_literal: true

shared_examples_for 'invalid create money transaction operation examples' do
  it 'does not create money transaction' do
    expect { operation }.not_to change(MoneyTransaction, :count)
  end

  it "does not update sender's balance" do
    expect { operation }.not_to(change { current_user.bank_account.reload.balance })
  end

  it "does not update recepient's balance" do
    expect { operation }.not_to(change { recepient.bank_account.reload.balance })
  end
end
