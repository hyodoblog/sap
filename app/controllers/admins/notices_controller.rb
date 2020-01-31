class Admins::NoticesController < Admins::ApplicationController
  def student
    student = current_admin.student.find(params[:id])
    unless student.nil?
      NotificationMailer.send_login_info(student, current_admin, new_student_session_path).deliver
    end
  end

  def laboratory

  end
end
