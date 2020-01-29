class NotificationMailer < ApplicationMailer

  # SAP起動時にログイン情報を学生と研究室に通知する
  def send_login_info(user, admin, password_init_url, login_url)
    @user = user
    @admin = admin
    @password_init_url = password_init_url
    @login_url = login_url
    mail( to: @user.email,
          subject: "SAPログイン情報の通知" )
  end
end
