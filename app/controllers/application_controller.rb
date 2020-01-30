class ApplicationController < ActionController::Base
  before_action :check_admin,      if: proc { admin_signed_in? }
  before_action :check_student,    if: proc { student_signed_in? }
  before_action :check_laboratory, if: proc { laboratory_signed_in? }

  # ログイン後のページ遷移
  def after_sign_in_path_for(resource)
    admins_root_path
  end

  private

  def check_admin
    
  end

  def check_sap_key
    if student_signed_in?
      redirect_to(root_path) if params[:sap_key] != current_student.admin.sap_key
    elsif laboratory_signed_in?
      redirect_to(root_path) if params[:sap_key] != current_laboratory.admin.sap_key
    end
  end
end
