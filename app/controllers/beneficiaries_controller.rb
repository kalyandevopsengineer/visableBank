class BeneficiariesController < ApplicationController
  def index
    @beneficiaries = Beneficiary.all
    json_response(@beneficiaries)
  end

  def show
    @beneficiary = Beneficiary.find_by_id(params[:id])
    if @beneficiary
      json_response(@beneficiary)
    else
      json_response({error: 'Beneficiary account doesn\'t exists.', status: 'Failed', code: 500})
    end
  end

  def new
    @beneficiary = Beneficiary.new(beneficiary_params)
    json_response(@beneficiary)
  end

  def create
    @beneficiary = Beneficiary.new(beneficiary_params)

    is_valid = @beneficiary.valid?
    if !is_valid
      json_response({error: @beneficiary.errors, status: 'Failed', code: 500})
    else
      @verify_account = Account.where(:account_number => @beneficiary[:beneficiary_number], :account_name => @beneficiary[:beneficiary_name])
      if @verify_account.empty?
        json_response({error: 'Beneficiary must be an account holder.', status: 'Failed', code: 500})
      else
        @beneficiary.save
        json_response(@beneficiary)
      end
    end
  end

  def edit
    @beneficiary = Beneficiary.find_by_id(params[:id])
    if @beneficiary
      json_response(@beneficiary)
    else
      json_response({error: 'Beneficiary doesn\'t exists.', status: 'Failed', code: 500})
    end
  end

  def update
    @beneficiary = Beneficiary.find_by_id(params[:id])
    if @beneficiary
      @status = @beneficiary[:beneficiary_status]

      if @status == true
        stat = 0
      else
        stat = 1
      end

      @beneficiary.update_attributes(:beneficiary_status => stat)
      json_response({message: 'Beneficiary account status updated.', status: 'Success', code: 200})
    else
      json_response({error: 'Beneficiary doesn\'t exists.', status: 'Failed', code: 500})
    end
  end

  def delete
    @beneficiary = Beneficiary.find_by_id(params[:id])
    if @beneficiary
      json_response(@beneficiary)
    else
      json_response({error: 'Beneficiary doesn\'t exists.', status: 'Failed', code: 500})
    end
  end

  def destroy
    @beneficiary = Beneficiary.find_by_id(params[:id])
    if @beneficiary
      id = @beneficiary[:id]
      is_mapped = AccountBeneficiary.where(:beneficiary_id => id)
      if is_mapped.count > 0
        json_response({error: 'Beneficiary may be associated with another account, remove mapping in join table.', status: 'Failed', code: 500})
      else
        @beneficiary.destroy
        json_response({message: 'Beneficiary deleted.', status: 'Success', code: 200})
      end
    end
  end

  private

  def beneficiary_params
    params.require(:beneficiary).permit(:beneficiary_number, :beneficiary_name, :beneficiary_status)
  end

end
