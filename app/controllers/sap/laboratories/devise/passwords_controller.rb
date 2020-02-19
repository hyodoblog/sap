# frozen_string_literal: true

class Sap::Laboratories::Devise::PasswordsController < Devise::PasswordsController
  include SapActions
  before_action :sap_key_check!  
  
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /:sap_key/resource/password
  # def create
  #   super
  # end

  # GET /:sap_key/resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /:sap_key/resource/password
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
