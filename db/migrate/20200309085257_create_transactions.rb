class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer "account_id"
      t.integer "beneficiary_id"
      t.integer "account_number", :limit => 8
      t.string "account_name"
      t.integer "beneficiary_number", :limit => 8
      t.string "beneficiary_name"
      t.decimal "amount_debited", :precision => 50, :scale => 2, :default => 0.0
      t.decimal "amount_credited", :precision => 50, :scale => 2, :default => 0.0
      t.timestamps
    end
    add_index("transactions", "account_id")
    add_index("transactions", "beneficiary_id")
    add_index("transactions", "account_number")
    add_index("transactions", "account_name")
    add_index("transactions", "beneficiary_number")
    add_index("transactions", "beneficiary_name")
  end

  def down
    drop_table :transactions
  end
end
