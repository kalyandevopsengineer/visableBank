class CreateBeneficiaries < ActiveRecord::Migration[5.0]
  def up
    create_table :beneficiaries do |t|
      t.integer "beneficiary_number", :limit => 8
      t.string "beneficiary_name"
      t.boolean "beneficiary_status", :default => true
      t.timestamps
    end
  end

  def down
    drop_table :beneficiaries
  end
end
