class CreateMoneyTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :money_transactions do |t|
      t.references :from, class_name: 'BankAccount', foreign_key: { to_table: :bank_accounts }, null: false
      t.references :to, class_name: 'BankAccount', foreign_key: { to_table: :bank_accounts }, null: false

      t.bigint :amount, null: false
      t.bigint :from_amount_after_transaction, null: false
      t.bigint :to_amount_after_transaction, null: false

      t.timestamps
    end
  end
end
