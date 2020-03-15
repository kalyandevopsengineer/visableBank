class CreateAccounts < ActiveRecord::Migration[5.0]

  def up
    create_table :accounts do |t|
      t.integer "account_number", :limit => 8 
      t.string "account_name"
      t.decimal "account_balance", :precision => 50, :scale => 2, :default => 0.0
      t.boolean "account_status", :default => true
      t.timestamps
    end
  end

  def down
    drop_table :accounts
  end

end
