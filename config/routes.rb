Rails.application.routes.draw do

  resources :accounts do
    member do
      get :delete
    end
  end

  resources :beneficiaries do
    member do
      get :delete
    end
  end

  resources :transactions do
    member do
      get :delete
    end
  end

  resources :account_beneficiaries do
    member do
      get :delete
    end
  end

end
