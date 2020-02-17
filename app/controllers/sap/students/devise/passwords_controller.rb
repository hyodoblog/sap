# frozen_string_literal: true

class Sap::Students::Devise::PasswordsController < Devise::PasswordsController
  include SapActions
  include UserAuthChecks
  before_action :sap_key_check!
  before_action :access_check!
  before_action :student_check!, except: [:new]
  
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end