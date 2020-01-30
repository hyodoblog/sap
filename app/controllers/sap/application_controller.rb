class Sap::ApplicationController < ApplicationController
  before_action :check_admin,
                :check_sap_key,
                :set_admin,
                :check_release_flag,
                :check_view_end_datetime

  private

  def check_admin
    if admin_signed_in?
      flash[:alert] = '管理者アカウントを一度ログアウトしてください！'
      redirect_back(fallback_location: root_path) and return
    end
  end

  def check_sap_key
    redirect_to(root_path) if params[:sap_key].nil?
  end

  def set_admin
    @admin = Admin.find_by(sap_key: params[:sap_key])
  end

  def check_release_flag
    if @admin.release_flag
      flash[:alert] = 'SAPが稼働していないためアクセスできません'
      redirect_to(sap_signin_path+'?sap_key='+params[:sap_key])
    end
  end

  def check_view_end_datetime
    now_datetime = Time.zone.now
    if now_datetime >= @admin.view_end_datetime
      flash[:alert] = '閲覧期限が過ぎています'
      redirect_to(sap_signin_path+'?sap_key='+params[:sap_key])
    end
  end
end
