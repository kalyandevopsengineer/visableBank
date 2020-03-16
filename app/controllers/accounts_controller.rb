class AccountsController < ApplicationController
  def index
    @account = Account.all
    json_response(@account)
  end

  def show
    @account = Account.find_by_id(params[:id])
    if @account
      json_response(@account)
    else
      json_response({error: 'Account doesn\'t exists.', status: 'Failed', code: 500})
    end
  end

  def new
    @account = Account.new(account_params)
    json_response(@account)
  end

  def create
    @account = Account.new(account_params)

    is_valid = @account.valid?
    if !is_valid
      json_response({error: @account.errors, status: 'Failed', code: 500})
    else
      @account.save
      json_response(@account)
    end
  end

  def edit
    @account = Account.find_by_id(params[:id])
    json_response(@account)
  end

  def update
    @account = Account.find_by_id(params[:id])
    if @account
      @status = @account[:account_status]

      if @status == true
        stat = 0
      else
        stat = 1
      end

      @account.update_attributes(:account_status => stat)
      json_response({message: 'Account status updated.', status: 'Success', code: 200})
    else
      json_response({error: 'Account doesn\'t exists.', status: 'Failed', code: 500})
    end
  end

  def delete
    @account = Account.find_by_id(params[:id])
    if @account
      json_response(@account)
    else
      json_response({error: 'Account doesn\'t exists.', status: 'Failed', code: 500})
    end
  end

  def destroy
    @account  = Account.find_by_id(params[:id])
    if @account
      verify_id = @account[:id]
      is_mapped = AccountBeneficiary.where(:account_id => verify_id)

      if is_mapped.count > 0
        json_response({error: 'Account may be associated with Beneficiary, remove mapping in join table.', status: 'Failed', code: 500})
      else
        @account.destroy
        json_response({message: 'Account deleted.', status: 'Success', code: 200})
      end
    else
      json_response({error: 'Account not found.', status: 'Failed', code: 500})
    end
  end

  private

  def account_params
    params.require(:account).permit(:account_number, :account_name, :account_balance)
  end

end
