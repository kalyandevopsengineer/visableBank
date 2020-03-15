class Account < ApplicationRecord
  has_and_belongs_to_many :beneficiaries
  has_many :account_beneficiaries

  validates_presence_of :account_name
  validates_length_of :account_name, :maximum => 255
  validates_presence_of :account_number
  validates_length_of :account_number, :within => 10..100
  validates_uniqueness_of :account_number
  validates_presence_of :account_balance
  validates_numericality_of :account_number, :only_integer => true
end
