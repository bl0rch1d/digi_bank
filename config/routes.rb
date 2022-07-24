Rails.application.routes.draw do
  devise_for(:users, only: %i[sessions registrations])

  resources :money_transactions, only: %i[create]

  root 'bank_accounts#show'
end
