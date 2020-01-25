class Admin::ReleaseController < Admin::ApplicationController
  before_action :set_config
  skip_before_action :check_release_flag!

  def on
    if @config.login_info_email_flag
      laboratories = Laboratory.where(user_id: current_user.id)
      students = Student.where(user_id: current_user.id)
      laboratories.each do |laboratory|
        Notification.send_login_info(laboratory, @config).deliver unless laboratory.email.empty?
      end
      students.each do |student|
        Notification.send_login_info(studnet, @config).deliver unless student.email.empty?
      end
    end
    @config.update_attributes(release_flag: true)
    flash[:notice] = 'SAPのログインページを発行しました'
    redirect_to(admin_root_path)
  end

  def off
    @config.update_attributes(release_flag: false)
    flash[:notice] = 'SAPの稼働を止めました'
    redirect_to(admin_root_path)
  end

  private

  def set_config
    @config = Config.find_by(user_id: current_user.id)
  end
end
