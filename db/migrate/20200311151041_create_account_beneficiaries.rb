class CreateAccountBeneficiaries < ActiveRecord::Migration[5.0]
  def up
    create_table :account_beneficiaries do |t|
      t.integer "account_id"
      t.integer "beneficiary_id"
      t.timestamps
    end
    add_index("account_beneficiaries", "account_id")
    add_index("account_beneficiaries", "beneficiary_id")
  end

  def down
    drop_table :account_beneficiaries
  end
end
