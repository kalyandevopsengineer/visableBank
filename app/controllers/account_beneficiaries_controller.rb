class AccountBeneficiariesController < ApplicationController

  def index
    @accountbeneficiary = AccountBeneficiary.all
    json_response(@accountbeneficiary)
  end

  def show
    @accountbeneficiary = AccountBeneficiary.find_by_id(params[:id])
    if @accountbeneficiary
      json_response(@accountbeneficiary)
    else
      json_response({error: 'Beneficiary doesn\'t exist.', status: 'Failed', code: 500})
    end
  end

  def new
    @accountbeneficiary = AccountBeneficiary.new(account_beneficiary_params)
    json_response(@accountbeneficiary)
  end

  def create
    @accountbeneficiary = AccountBeneficiary.new(account_beneficiary_params)

    account_status      = Account.where(:id => @accountbeneficiary[:account_id], :account_status => 1)
    beneficiary_status  = Beneficiary.where(:id => @accountbeneficiary[:beneficiary_id], :beneficiary_status => 1)

    if account_status.count > 0 && beneficiary_status.count > 0
      @verify_account     = Account.find_by_id(@accountbeneficiary[:account_id])
      @verify_beneficiary = Beneficiary.find_by_id(@accountbeneficiary[:beneficiary_id])

      if @verify_account && @verify_beneficiary
        account = @verify_account[:account_number]
        beneficiary = @verify_beneficiary[:beneficiary_number]
        record_exists = AccountBeneficiary.where(:account_id => @accountbeneficiary[:account_id], :beneficiary_id => @accountbeneficiary[:beneficiary_id])

        if account == beneficiary
          json_response({error: 'Account holder cannot transfer amount to his own account.', status: 'Failed', code: 500})
        elsif record_exists.count > 0
          json_response({error: 'Account and Beneficiary association already exist.', status: 'Failed', code: 500})
        else
          @accountbeneficiary.save
          json_response(@accountbeneficiary)
        end
      else
        json_response({error: 'Account and/or Beneficiary doesn\'t exists.', status: 'Failed', code: 500})
      end
    else
      json_response({error: 'Amount transfer cannot execute on inactive accounts and/or beneficiaries.', status: 'Failed', code: '500'})
    end
  end

  def edit
    json_response({error: 'Edit operation not supported.', status: 'Failed', code: 500})
  end

  def update
    json_response({error: 'Update operation not supported.', status: 'Failed', code: 500})
  end

  def delete
    @accountbeneficiary = AccountBeneficiary.find_by_id(params[:id])
    json_response(@accountbeneficiary)
  end

  def destroy
    @accountbeneficiary = AccountBeneficiary.find_by_id(params[:id])
    if @accountbeneficiary
      @accountbeneficiary.destroy
      json_response(@accountbeneficiary)
    else
      json_response({error: 'Account and/or Beneficiary doesn\'t exists.', status: 'Failed', code: 500})
    end
  end

  private

  def account_beneficiary_params
    params.require(:account_beneficiary).permit(:account_id, :beneficiary_id, :account_status, :beneficiary_status)
  end

end
