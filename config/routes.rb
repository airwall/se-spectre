Rails.application.routes.draw do
  devise_for :users, skip: :passwords

  root "logins#index"

  get "activate", to: "customers#activate", as: :activate
  resources :customers, only: %i(index show) do
    resources :logins, only: :create
    post "token", to: "logins#token", as: :token
  end
  resources :logins, only: %i(show index) do
    post "refresh", to: "logins#refresh", as: :refresh
    post "reconnect", to: "logins#reconnect", as: :reconnect
    post "destroy", to: "logins#destroy", as: :destroy
  end

  get "oops", to: "application#bad_request", as: :oops
end
