class Sap::ApplicationController < ApplicationController
  before_action :check_sap_key, :set_config, :check_view_end_datetime

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
    admin_id = Config.find_by(sap_key: params[:sap_key]).user_id
    @config = Config.find_by(user_id: admin_id)
  end

  def check_view_end_datetime
    view_end_datetime = Config.find_by(sap_key: params[:sap_key]).view_end_datetime
    now_datetime = Time.zone.now
    if now_datetime >= view_end_datetime
      redirect_to(sap_assign_list_path+'?sap_key='+params[:sap_key])
    end
  end
end
