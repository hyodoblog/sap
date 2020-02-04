Rails.application.routes.draw do
  root   'home#index'
  get    'privacy', to: 'home#privacy'

  namespace :admins do
    root   'home#index'
    get    'init_setup/first'
    put    'init_setup/first', to: 'init_setup#first_setup'
    patch  'init_setup/first', to: 'init_setup#first_setup'
    get    'init_setup/first_skip'
    get    'init_setup/second'
    post   'init_setup/second/csv', to: 'init_setup#second_setup_csv'
    post   'init_setup/second/excel', to: 'init_setup#second_setup_excel'
    get    'init_setup/second_skip'
    get    'import',       to: 'imports#new'
    post   'import/csv',   to: 'imports#csv'
    post   'import/excel', to: 'imports#excel'
    get    'download/laboratory'
    get    'download/student'
    delete 'init/all'
    delete 'init/laboratory'
    delete 'init/student'
    delete 'init/sap'
    get    'config/show'
    get    'config/edit'
    put    'config', to: 'config#update'
    patch  'config', to: 'config#update'
    get    'mypage/show'
    put    'release/on'
    patch  'release/on'
    put    'release/off'
    patch  'release/off'
    put    'release/force_termination'
    patch  'release/force_termination'
    post   'notices/:id/student',    to: 'notices#student'
    post   'notices/:id/laboratory', to: 'notices#laboratory'
    post   'algorithm/manual'
    get    'exports/index'
    resources :laboratories, only: [:new, :create, :edit, :update, :destroy]
    resources :students,    only: [:new, :create, :edit, :update, :destroy]
  end

  # sap
  get  ':sap_key/students',     to: 'sap/students/home#index',     as: :students_root
  post ':sap_key/students',     to: 'sap/students/home#choice'
  get  ':sap_key/laboratories', to: 'sap/laboratories/home#index', as: :laboratories_root
  post ':sap_key/laboratories', to: 'sap/laboratories/home#choice'
  get  ':sap_key/assign_lists', to: 'sap/assign_lists#index',      as: :assign_lists

  # devise
  devise_for :admins, skip: [:session, :registration, :password],
             controllers: {
               confirmations: 'admins/devise/confirmations'
             }
  devise_scope :admin do
    get    'sign_in',            to: 'admins/devise/sessions#new',          as: :new_admin_session
    post   'sign_in',            to: 'admins/devise/sessions#create',       as: :admin_session
    delete 'sign_out',           to: 'admins/devise/sessions#destroy',      as: :destroy_admin_session
    get    'sign_up',            to: 'admins/devise/registrations#new',     as: :new_admin_registration
    post   'sign_up',            to: 'admins/devise/registrations#create',  as: :admin_registration
    # get    'sign_up/cancel',    to: 'admins/devise/registrations#cancel',  as: :cancel_admin_registration
    get    'admins/mypage/edit', to: 'admins/devise/registrations#edit',    as: :edit_admin_registration
    patch  'admins/mypage',      to: 'admins/devise/registrations#update',  as: :update_admin_registration
    put    'admins/mypage',      to: 'admins/devise/registrations#update',  as: nil
    delete 'admins/mypage',      to: 'admins/devise/registrations#destroy', as: :destroy_admin_registration
    get    'password',           to: 'admins/devise/passwords#new',         as: :new_admin_password
    post   'password',           to: 'admins/devise/passwords#create',      as: :admin_password
    get    'password/edit',      to: 'admins/devise/passwords#edit',        as: :edit_admin_password
    patch  'password',           to: 'admins/devise/passwords#update',      as: :update_admin_password
    put    'password',           to: 'admins/devise/passwords#update',      as: nil
  end
  devise_for :students, skip: [:session, :password, :registration]
  devise_scope :student do
    get    ':sap_key/students/sign_in',       to: 'sap/students/devise/sessions#new',          as: :new_student_session
    post   ':sap_key/students/sign_in',       to: 'sap/students/devise/sessions#create',       as: :student_session
    delete ':sap_key/students/sign_out',      to: 'sap/students/devise/sessions#destroy',      as: :destroy_student_session
    get    ':sap_key/students/password',      to: 'sap/students/devise/passwords#new',         as: :new_student_password
    post   ':sap_key/students/password',      to: 'sap/students/devise/passwords#create',      as: :student_password
    get    ':sap_key/students/password/edit', to: 'sap/students/devise/passwords#edit',        as: :edit_student_password
    patch  ':sap_key/students/password',      to: 'sap/students/devise/passwords#update',      as: :update_student_password
    put    ':sap_key/students/password',      to: 'sap/students/devise/passwords#update',      as: nil
  end
  devise_for :laboratories, skip: [:session, :password, :registration]
  devise_scope :laboratory do
    get    ':sap_key/laboratories/sign_in',       to: 'sap/laboratories/devise/sessions#new',          as: :new_laboratory_session
    post   ':sap_key/laboratories/sign_in',       to: 'sap/laboratories/devise/sessions#create',       as: :laboratory_session
    delete ':sap_key/laboratories/sign_out',      to: 'sap/laboratories/devise/sessions#destroy',      as: :destroy_laboratory_session
    get    ':sap_key/laboratories/password',      to: 'sap/laboratories/devise/passwords#new',         as: :new_laboratory_password
    post   ':sap_key/laboratories/password',      to: 'sap/laboratories/devise/passwords#create',      as: :laboratory_password
    get    ':sap_key/laboratories/password/edit', to: 'sap/laboratories/devise/passwords#edit',        as: :edit_laboratory_password
    patch  ':sap_key/laboratories/password',      to: 'sap/laboratories/devise/passwords#update',      as: :update_laboratory_password
    put    ':sap_key/laboratories/password',      to: 'sap/laboratories/devise/passwords#update',      as: nil
  end
end
