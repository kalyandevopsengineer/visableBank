class TransactionsController < ApplicationController
  def index
    @transaction = Transaction.all
    json_response(@transaction)
  end

  def show
    @transaction = Transaction.where(:account_id => params[:id]).order("id DESC").limit(10)
    json_response(@transaction)
  end

  def new
    @transaction = Transaction.new(transaction_params)
    json_response(@transaction)
  end

  def create
    @transaction  = Transaction.new(transaction_params)
    @account      = Account.where(:id => params[:account_id], :account_status => 1)
    @beneficiary  = Beneficiary.where(:id => params[:beneficiary_id], :beneficiary_status => 1)
    @associate    = AccountBeneficiary.where(:account_id => params[:account_id], :beneficiary_id => params[:beneficiary_id])

    is_valid = @transaction.valid?
    if !is_valid
      json_response({error: @transaction.errors, status: 'Failed', code: 500})
    end

    if @associate.count > 0
      if @account.count > 0 && @beneficiary.count > 0
        @account.each do |acc|
          @account_balance = acc[:account_balance]
        end

        @account_debit   = @transaction[:amount_debited]
        @account_credit  = @transaction[:amount_credited]

        if @account_debit > @account_balance
          json_response({error: 'Insufficient Account balance. Transaction cannot be completed.', status: 'Failed', code: 500})
        elsif @account_credit != @account_debit
          json_response({error: 'Account balance debit and credit mismatch.', status: 'Failed', code: 500})
        else
          @update_account = Account.find_by_id(params[:account_id])
          @update_balance = Account.where(:account_number => params[:beneficiary_number])

          @update_balance.each do |up|
            @beneficiaries_balance = up[:account_balance]
            @id_of_account = up[:id]
          end

          @id_account  = Account.find_by_id(@id_of_account)

          available_balance = @account_balance - @account_debit
          transfer_balance  = @beneficiaries_balance + @account_credit

          @transaction.save

          @update_account.update_attributes(:account_balance => available_balance)
          @id_account.update_attributes(:account_balance => transfer_balance)

          json_response({message: 'Transaction successful.', status: 'Success', code: 200})
        end
      else
        json_response({error: 'Account and Beneficiary status must be active.', status: 'Failed', code: 500})
      end
    else
      json_response({error: 'Account and Beneficiary must be associated.', status: 'Failed', code: 500})
    end
  end

  def edit
    json_response({error: 'Transaction information cannot be updated.', status: 'Failed', code: 500})
  end

  def update
    json_response({error: 'Transaction information cannot be updated.', status: 'Failed', code: 500})
  end

  def delete
    json_response({error: 'Transaction information cannot be deleted.', status: 'Failed', code: 500})
  end

  def destroy
    json_response({error: 'Beneficiary may be associated with another account, remove mapping in join table.', status: 'Failed',  code: 500})
  end

  private

  def transaction_params
    params.require(:transaction).permit(:account_id, :beneficiary_id, :account_number, :account_name, :beneficiary_number, :beneficiary_name, :amount_debited, :amount_credited)
  end

end
