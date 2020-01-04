Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    get    'mypage', to: 'mypage#index'
    get    'init_setup/first'
    put    'init_setup/first', to: 'init_setup#first_setup'
    patch  'init_setup/first', to: 'init_setup#first_setup'
    get    'init_setup/first_skip'
    get    'init_setup/second'
    post   'init_setup/second', to: 'init_setup#second_setup'
    get    'init_setup/second_skip'
    get    'csv_import/new'
    post   'csv_import/create'
    get    'download/laboratory'
    get    'download/student'
    get    'config/edit'
    put    'config/update'
    patch  'config/update'
    delete 'init/all'
    delete 'init/laboratory'
    delete 'init/student'
    resources :laboratories, only: [:new, :create, :edit, :update, :destroy]
    resources :students,     only: [:new, :create, :edit, :udpate, :destroy]
  end

  # sap
  namespace :sap do
    get    'signin', to: 'sessions#new'
    post   'signin', to: 'sessions#create'
    delete 'signout', to: 'sessions#destroy'
    get 'laboratory/index'
    get 'laboratory/choice'
    get 'student/index'
    get 'student/choice'
    get 'assign_list/index'
  end

  devise_for :users, skip: :all

  devise_scope :user do
    get 'signin',           to: 'devise/sessions#new',          as: :new_user_session
    post 'signin',          to: 'devise/sessions#create',       as: :user_session
    delete 'signout',       to: 'devise/sessions#destroy',      as: :destroy_user_session
    get 'signup',           to: 'devise/registrations#new',     as: :new_user_registration
    post 'signup',          to: 'devise/registrations#create',    as: :user_registration
    get 'signup/cancel',    to: 'devise/registrations#cancel',  as: :cancel_user_registration
    #get 'mypage/edit',      to: 'devise/registrations#edit',      as: :edit_user_registration
    #patch 'mypage',         to: 'devise/registrations#update'
    #put 'mypage',           to: 'devise/registrations#update',    as: :update_user_registration
    delete 'mypage',        to: 'devise/registrations#destroy', as: :destroy_user_registration
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
end
