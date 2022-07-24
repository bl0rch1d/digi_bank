class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
