class NotificationMailer < ApplicationMailer

  # SAP起動時にログイン情報を学生と研究室に通知する
  def send_login_info(user, admin, login_url)
    @user = user
    @admin = admin
    @login_url = login_url
    mail( to: @user.email,
          subject: "SAPへのログイン情報通知" )
  end
end
