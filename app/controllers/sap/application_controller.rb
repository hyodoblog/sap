class Sap::ApplicationController < ApplicationController
  before_action :check_sap_key, :set_config

  private

  def check_sap_key
    if session[:sap_key]
      admin_id = Config.find_by(sap_key: session[:sap_key]).user_id
      if session[:laboratory_id]
        user_id = Laboratory.find(session[:laboratory_id]).user_id
      elsif session[:student_id]
         user_id = Student.find(session[:student_id]).user_id
      end
      unless user_id === admin_id
        redirect_to(sap_signin_path+"?sap_key="+session[:sap_key])
      end
    else
      redirect_to(sap_signin_path+"?sap_key="+params[:sap_key])
    end
  end

  def set_config
    if user_signed_in?
      sap_key = current_user.config.sap_key
    else
      sap_key = params[:sap_key]
    end
    admin_id = Config.find_by(sap_key: sap_key)
    @config = Config.find_by(user_id: admin_id)
  end
end
