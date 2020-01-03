Rails.application.routes.draw do
  devise_for :users, skip: :all

  devise_scope :user do
    get 'signin',           to: 'devise/sessions#new',          as: :new_user_session
    post 'signin',          to: 'devise/sessions#create',       as: :user_session
    delete 'signout',       to: 'devise/sessions#destroy',      as: :destroy_user_session
    get 'signup',           to: 'devise/registrations#new',     as: :new_user_registration
    post 'signup',          to: 'devise/registrations#create',  as: :user_registration
    get 'signup/cancel',    to: 'devise/registrations#cancel',  as: :cancel_user_registration
    get 'user',             to: 'devise/registrations#edit',    as: :edit_user_registration
    patch 'user',           to: 'devise/registrations#update'
    put 'user',             to: 'devise/registrations#update',  as: :update_user_registration
    delete 'user',          to: 'devise/registrations#destroy', as: :destroy_user_registration
    get 'password',         to: 'devise/passwords#new',         as: :new_user_password
    post 'password',        to: 'devise/passwords#create',      as: :user_password
    get 'password/edit',    to: 'devise/passwords#edit',        as: :edit_user_password
    patch 'password',       to: 'devise/passwords#update'
    put 'password',         to: 'devise/passwords#update',      as: :update_user_password
    get 'confirmation/new', to: 'devise/confirmations#new',     as: :new_user_confirmation
    get 'confirmation',     to: 'devise/confirmations#show',    as: :user_confirmation
    post 'confirmation',    to: 'devise/confirmations#create'
  end
  resources :users

  root 'home#index'

  # sap
  
end
