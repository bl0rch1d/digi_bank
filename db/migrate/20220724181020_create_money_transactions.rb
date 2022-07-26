class CreateMoneyTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :money_transactions do |t|
      t.references :sender, class_name: 'BankAccount', foreign_key: { to_table: :bank_accounts }, null: false
      t.references :recepient, class_name: 'BankAccount', foreign_key: { to_table: :bank_accounts }, null: false

      t.bigint :amount, null: false
      t.bigint :sender_balance_after_transaction, null: false
      t.bigint :recepient_balance_after_transaction, null: false

      t.timestamps
    end
  end
end
