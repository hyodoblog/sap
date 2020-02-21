class Admins::MailNoticesController < Admins::ApplicationController
  skip_before_action :release_true_check!
  before_action :release_false_check!

  def student
    student = current_admin.student.find(params[:id])
    if student.present?
      NotificationMailer.send_login_info(student, current_admin, 'sap/students/devise/sessions').deliver
      flash[:notice] = student.name + "にログイン情報を通知しました"
    else
      flash[:alert] = '学生情報の取得に失敗しました'
    end
    redirect_to(admins_root_path)
  end

  def laboratory
    laboratory = current_admin.laboratory.find(params[:id])
    if laboratory.present?
      NotificationMailer.send_login_info(laboratory, current_admin, 'sap/laboratories/devise/sessions').deliver
      flash[:notice] = laboratory.name + "にログイン情報を通知しました"
    else
      flash[:alert] = '研究室情報の取得に失敗しました'
    end
    redirect_to(admins_root_path)
  end

  def student_all
    send_student
    flash[:notice] = "学生全員にログイン情報を通知しました"
    redirect_to(admins_root_path)
  end

  def laboratory_all
    send_laboratory
    flash[:notice] = "研究室全員にログイン情報を通知しました"
    redirect_to(admins_root_path)
  end

  def all
    send_student
    send_laboratory
    flash[:notice] = "登録ユーザー全員にログイン情報を通知しました"
    redirect_to(admins_root_path)
  end

  private

  def send_student
    current_admin.student.each do |student|
      NotificationMailer.send_login_info(student, current_admin, 'sap/students/devise/sessions').deliver
    end
  end

  def send_laboratory
    current_admin.laboratory.each do |laboratory|
      NotificationMailer.send_login_info(laboratory, current_admin, 'sap/laboratories/devise/sessions').deliver
    end
  end
end
