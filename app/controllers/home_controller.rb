class HomeController < ApplicationController
  before_action :redirect_admin_path,      if: -> { user_signed_in? }
  before_action :redirect_laboratory_path, if: -> { session[:laboratory_id] }
  before_action :redirect_student_path,    if: -> { session[:student_id] }

  def index
  end

  private

  def redirect_admin_path
    redirect_to(admin_root_path)
  end

  def redirect_laboratory_path
    redirect_to(sap_laboratory_path+'?sap_key='+session[:sap_key])
  end

  def redirect_student_path
    redirect_to(sap_student_path+'?sap_key='+session[:sap_key])
  end
end
