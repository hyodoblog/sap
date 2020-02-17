class Admins::NoticesController < Admins::ApplicationController
  def student
    student = current_admin.student.find(params[:id])
    if student.present?
      NotificationMailer.send_login_info(student, current_admin, 'sap/students/devise/sessions').deliver
    else
      flash[:notice] = '学生情報の取得に失敗しました'
    end
    redirect_to(admins_root_path)
  end

  def laboratory
    laboratory = current_admin.laboratory.find(params[:id])
    if laboratory.present?
      NotificationMailer.send_login_info(laboratory, current_admin, 'sap/laboratories/devise/sessions').deliver
    else
      flash[:notice] = '研究室情報の取得に失敗しました'
    end
    redirect_to(admins_root_path)
  end
end