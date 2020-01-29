class Sap::ApplicationController < ApplicationController
  before_action :check_sap_key, :set_admin, :check_release_flag, :check_view_end_datetime

  private

  def check_sap_key
    if params[:sap_key]
      begin
        admin_id = User.find_by(sap_key: params[:sap_key]).id
      rescue
        redirect_to(root_path)
      end
      if session[:sap_key]
        if session[:laboratory_id]
          user_id = Laboratory.find(session[:laboratory_id]).user_id
        elsif session[:student_id]
          user_id = Student.find(session[:student_id]).user_id
        end
        unless user_id == admin_id
          redirect_to(sap_signin_path+"?sap_key="+session[:sap_key])
        end
      end
    else
      redirect_to(root_path)
    end
  end

  def set_admin
    @admin = User.find_by(sap_key: params[:sap_key])
  end

  def check_release_flag
    begin
      unless User.find_by(sap_key: params[:sap_key]).release_flag
        flash[:alert] = 'SAPが稼働していないためアクセスできません'
        redirect_to(sap_signin_path+'?sap_key='+params[:sap_key])
      end
    rescue
      redirect_to(root_path)
    end
  end

  def check_view_end_datetime
    view_end_datetime = User.find_by(sap_key: params[:sap_key]).view_end_datetime
    now_datetime = Time.zone.now
    if now_datetime >= view_end_datetime
      flash[:alert] = '閲覧期限が過ぎています'
      redirect_to(sap_signin_path+'?sap_key='+params[:sap_key])
    end
  end
end
