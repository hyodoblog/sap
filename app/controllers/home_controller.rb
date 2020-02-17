class HomeController < ApplicationController
  before_action :login_check

  def index
  end

  def privacy
  end

  private

  def login_check
    if current_admin.present?
      redirect_to(admins_root_path)
    elsif current_student.present?
      redirect_to(students_root_path(current_student.admin.sap_key))
    elsif current_laboratory.present?
      redirect_to(laboratories_root_path(current_laboratory.admin.sap_key))
    end
  end
end
