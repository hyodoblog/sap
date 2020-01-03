# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    user = User.new(configure_sign_up_params)
    user.save()
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    edit_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:sap_key, :university_name, :faculty_name, :department_name, :contact_email,
             :max_choice_student, :max_choice_laboratory, :start_datetime, :end_datetime,
             :release_flag, :init_setup_flag])
  end

  # パラメーターを強引に変更
  # htmlにhiddenとして書くのはセキュリティ的に良くないと感じた
  def edit_sign_up_params
    params[:user] = { sap_key: User.generate_sap_key,
                      university_name: '〇〇大学',
                      start_datetime:  DateTime.now,
                      end_datetime:    DateTime.now }
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
