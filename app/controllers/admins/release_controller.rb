class Admins::ReleaseController < Admins::ApplicationController
  skip_before_action :check_release_flag!

  def on
    if current_admin.login_info_email_flag
      laboratories = Laboratory.where(admin_id: current_admin.id)
      students = Student.where(admin_id: current_admin.id)
      laboratories.each do |laboratory|
        NotificationMailer.send_login_info(laboratory, current_admin, sap_signin_path).deliver unless laboratory.email.empty?
      end
      students.each do |student|
        NotificationMailer.send_login_info(studnet, current_admin, sap_signin_path).deliver unless student.email.empty?
      end
    end
    current_admin.update_attributes(release_flag: true)
    flash[:notice] = 'SAPのログインページを発行しました'
    redirect_to(admins_root_path)
  end

  def off
    current_admin.update_attributes(release_flag: false)
    flash[:notice] = 'SAPの稼働を一時停止しました'
    redirect_to(admins_root_path)
  end
end
