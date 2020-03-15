class Beneficiary < ApplicationRecord
  has_and_belongs_to_many :accounts, :join_table => 'account_beneficiaries'
  has_many :account_beneficiaries

  validates_presence_of :beneficiary_name
  validates_length_of :beneficiary_name, :maximum => 255
  validates_presence_of :beneficiary_number
  validates_length_of :beneficiary_number, :within => 10..100
  validates_uniqueness_of :beneficiary_number
  validates_numericality_of :beneficiary_number, :only_integer => true
end
