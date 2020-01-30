Rails.application.routes.draw do
  root   'home#index'
  get    'privacy', to: 'home#privacy'

  namespace :admin do
    root   'home#index'
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
    delete 'init/all'
    delete 'init/laboratory'
    delete 'init/student'
    get    'config/show'
    get    'config/edit'
    put    'config', to: 'config#update'
    patch  'config', to: 'config#update'
    get    'mypage/show'
    put    'release/on'
    patch  'release/on'
    put    'release/off'
    patch  'release/off'
    post   'algorithm/manual'
    resources :laboratory, only: [:new, :create, :edit, :update, :destroy]
    resources :student,    only: [:new, :create, :edit, :update, :destroy]
  end

  # sap
  namespace :students do
    root 'home#index'
  end
  namespace :laboratories do
    root 'home#index'
  end

  # devise
  devise_for :admins, skip: [:session, :registration, :password],
             controllers: {
               confirmation: 'students/devise/confirmations'
             }
  devise_scope :admin do
    get    'sign_in',           to: 'admins/devise/sessions#new'
    post   'sign_in',           to: 'admins/devise/sessions#create'
    delete 'sign_out',          to: 'admins/devise/sessions#destroy'
    get    'sign_up',           to: 'admins/devise/registrations#new'
    post   'sign_up',           to: 'admins/devise/registrations#create'
    # get    'sign_up/cancel',    to: 'admins/devise/registrations#cancel'
    get    'mypage/edit',       to: 'admins/devise/registrations#edit'
    patch  'mypage',            to: 'admins/devise/registrations#update'
    put    'mypage',            to: 'admins/devise/registrations#update'
    delete 'mypage',            to: 'admins/devise/registrations#destroy'
    get    'password',          to: 'admins/devise/passwords#new'
    post   'password',          to: 'admins/devise/passwords#create'
    get    'password/edit',     to: 'admins/devise/passwords#edit'
    patch  'password',          to: 'admins/devise/passwords#update'
    put    'password',          to: 'admins/devise/passwords#update'
  end
  devise_for :students, controllers: {
    sessions:      'students/devise/sessions',
    passwords:     'students/devise/passwords',
    registrations: 'students/devise/registrations'
  }
  devise_for :laboratories, controllers: {
    sessions:      'laboratories/devise/sessions',
    passwords:     'laboratories/devise/passwords',
    registrations: 'laboratories/devise/registrations'
  }
end
