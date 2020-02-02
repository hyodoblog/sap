class Admins::ReleaseController < Admins::ApplicationController
  def on
    if current_admin.login_info_email_flag && !current_admin.start_flag
      current_admin.laboratory.each do |laboratory|
        NotificationMailer.send_login_info(laboratory, current_admin, new_laboratory_session_path+'?sap_key='+current_admin.sap_key).deliver
      end
      current_admin.student.each do |student|
        NotificationMailer.send_login_info(student, current_admin, new_student_session_path+'?sap_key='+current_admin.sap_key).deliver
      end
    end
    current_admin.update_attributes(release_flag: true, start_flag: true)
    flash[:notice] = 'SAPのログインページを発行しました'
    redirect_to(admins_root_path)
  end

  def off
    current_admin.update_attributes(release_flag: false)
    flash[:notice] = 'SAPの稼働を一時停止しました'
    redirect_to(admins_root_path)
  end
end
