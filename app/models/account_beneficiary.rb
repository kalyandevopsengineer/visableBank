class AccountBeneficiary < ApplicationRecord
  belongs_to :account
  belongs_to :beneficiary
end
