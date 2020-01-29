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
  namespace :sap do
    namespace :students do
      root   'home#index'
      post   '/',             to: 'home#choice'
      get    'signin',        to: 'sessions#new'
      post   'signin',        to: 'sessions#create'
      delete 'signout',       to: 'sessions#destroy'
      get    'password/new',  to: 'password#new'
      post   'password',      to: 'password#create'
      get    'password/edit', to: 'password#edit'
      put    'password'  ,    to: 'password#update'
      patch  'password',      to: 'password#update'
    end
    namespace :laboratories do
      root   'home#index'
      post   '/',             to: 'home#choice'
      get    'signin',        to: 'sessions#new'
      post   'signin',        to: 'sessions#create'
      delete 'signout',       to: 'sessions#destroy'
      get    'password/new',  to: 'password#new'
      post   'password',      to: 'password#create'
      get    'password/edit', to: 'password#edit'
      put    'password'  ,    to: 'password#update'
      patch  'password',      to: 'password#update'
    end
    get    'assign_list', to: 'assign_list#index'
  end

  # devise
  devise_for :admins, skip: :sessions
  devise_scope :admin do
    get    'signin',            to: 'admin/devise/sessions#new'
    post   'signin',            to: 'admin/devise/sessions#create'
    delete 'signout',           to: 'admin/devise/sessions#destroy'
    get    'signup',            to: 'admin/devise/registrations#new'
    post   'signup',            to: 'admin/devise/registrations#create'
    get    'signup/cancel',     to: 'admin/devise/registrations#cancel'
    get    'admin/mypage/edit', to: 'admin/devise/registrations#edit'
    patch  'admin',             to: 'admin/devise/registrations#update'
    put    'admin',             to: 'admin/devise/registrations#update'
    delete 'admin',             to: 'admin/devise/registrations#destroy'
    get    'password',          to: 'admin/devise/passwords#new'
    post   'password',          to: 'admin/devise/passwords#create'
    get    'password/edit',     to: 'admin/devise/passwords#edit'
    patch  'password',          to: 'admin/devise/passwords#update'
    put    'password',          to: 'admin/devise/passwords#update'
    get    'confirmation/new',  to: 'admin/devise/confirmations#new'
    get    'confirmation',      to: 'admin/devise/confirmations#show'
    post   'confirmation',      to: 'admin/devise/confirmations#create'
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
