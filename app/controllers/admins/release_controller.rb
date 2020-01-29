class Admin::ReleaseController < Admin::ApplicationController
  skip_before_action :check_release_flag!

  def on
    if current_user.login_info_email_flag
      laboratories = Laboratory.where(user_id: current_user.id)
      students = Student.where(user_id: current_user.id)
      laboratories.each do |laboratory|
        NotificationMailer.send_login_info(laboratory, current_user, sap_signin_path).deliver unless laboratory.email.empty?
      end
      students.each do |student|
        NotificationMailer.send_login_info(studnet, current_user, sap_signin_path).deliver unless student.email.empty?
      end
    end
    current_user.update_attributes(release_flag: true)
    flash[:notice] = 'SAPのログインページを発行しました'
    redirect_to(admin_root_path)
  end

  def off
    current_user.update_attributes(release_flag: false)
    flash[:notice] = 'SAPの稼働を一時停止しました'
    redirect_to(admin_root_path)
  end
end
