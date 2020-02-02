class NotificationMailer < ApplicationMailer

  # SAP起動時にログイン情報を学生と研究室に通知する
  def send_login_info(user, admin, controller_path)
    @user = user
    @admin = admin
    @controller_path = controller_path
    mail( to: @user.email,
          subject: "SAPへのログイン情報通知" )
  end
end
