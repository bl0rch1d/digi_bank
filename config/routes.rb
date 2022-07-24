Rails.application.routes.draw do
  devise_for(:users, only: %i[sessions registrations])
end
