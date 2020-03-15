class Transaction < ApplicationRecord
  validates_presence_of :amount_credited
  validates_length_of :amount_credited, :within => 1..100
  validates_presence_of :amount_debited
  validates_length_of :amount_debited, :within => 1..100
end
