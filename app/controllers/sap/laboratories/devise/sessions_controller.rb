# frozen_string_literal: true

class Sap::Laboratories::Devise::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include SapActions
  include UserAuthChecks
  before_action :sap_key_check!
  before_action :session_check!
  before_action :laboratory_check!, except: [:new]

  # GET /:sap_key/resource/sign_in
  # def new
  #   super
  # end

  # POST /:sap_key/resource/sign_in

  # DELETE /:sap_key/resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
