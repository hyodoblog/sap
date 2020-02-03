# frozen_string_literal: true

class Sap::Students::Devise::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include SapActions
  include UserAuthChecks
  before_action :sap_key_check!
  before_action :session_check!
  before_action :student_check!, except: [:new]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message!(:notice, :signed_in)
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?
  #   redirect_to(after_sign_in_path_for(resource))
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
