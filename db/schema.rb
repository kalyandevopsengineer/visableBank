# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200311151041) do

  create_table "account_beneficiaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "account_id"
    t.integer  "beneficiary_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["account_id"], name: "index_account_beneficiaries_on_account_id", using: :btree
    t.index ["beneficiary_id"], name: "index_account_beneficiaries_on_beneficiary_id", using: :btree
  end

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint   "account_number"
    t.string   "account_name"
    t.decimal  "account_balance", precision: 50, scale: 2, default: "0.0"
    t.boolean  "account_status",                           default: true
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "beneficiaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint   "beneficiary_number"
    t.string   "beneficiary_name"
    t.boolean  "beneficiary_status", default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "account_id"
    t.integer  "beneficiary_id"
    t.bigint   "account_number"
    t.string   "account_name"
    t.bigint   "beneficiary_number"
    t.string   "beneficiary_name"
    t.decimal  "amount_debited",     precision: 50, scale: 2, default: "0.0"
    t.decimal  "amount_credited",    precision: 50, scale: 2, default: "0.0"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.index ["account_id"], name: "index_transactions_on_account_id", using: :btree
    t.index ["account_name"], name: "index_transactions_on_account_name", using: :btree
    t.index ["account_number"], name: "index_transactions_on_account_number", using: :btree
    t.index ["beneficiary_id"], name: "index_transactions_on_beneficiary_id", using: :btree
    t.index ["beneficiary_name"], name: "index_transactions_on_beneficiary_name", using: :btree
    t.index ["beneficiary_number"], name: "index_transactions_on_beneficiary_number", using: :btree
  end

end
