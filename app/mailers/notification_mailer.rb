class NotificationMailer < ApplicationMailer

  # SAP起動時にログイン情報を学生と研究室に通知する
  def send_login_info(user, config)
    @user = user
    @config = config
    mail( to: @user.email,
          subject: "SAPログイン情報の通知" )
  end
end
