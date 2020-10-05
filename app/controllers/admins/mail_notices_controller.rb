class Admins::MailNoticesController < Admins::ApplicationController
  skip_before_action :release_true_check!
  before_action :release_false_check!

  def student
    student = current_admin.student.find(params[:id])
    if student.present?
      send_mail(student, current_admin, 'students')
      # NotificationMailer.send_login_info(student, current_admin, 'sap/students/devise/sessions').deliver
      flash[:notice] = student.name + "にログイン情報を通知しました"
    else
      flash[:alert] = '学生情報の取得に失敗しました'
    end
    redirect_to(admins_root_path)
  end

  def laboratory
    laboratory = current_admin.laboratory.find(params[:id])
    if laboratory.present?
      send_mail(laboratory, current_admin, 'laboratories')
      # NotificationMailer.send_login_info(laboratory, current_admin, 'sap/laboratories/devise/sessions').deliver
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

  def send_mail(user, admin, type)
    # university_name = admin.university_name
    # faculty_name = admin.faculty_name
    # department_name = admin.department_name
    name = user.name
    login_link = 'https://sap.hyodoblog.com/' + admin.sap_key + '/' + type + '/sign_in'
    email = user.email
    password_init = user.password_init
    # end_datetime = admin.end_datetime.to_s(:datetime_jp)
    # view_end_datetime = admin.view_end_datetime.to_s(:datetime_jp)
    api_key = ENV['API_KEY']
    url = `https://asia-northeast1-test-pg-yukihira-280008.cloudfunctions.net/sapSendMail?name=#{name}&login_link=#{login_link}&email=#{email}&password_init=#{password_init}&api_key=#{api_key}`
    host = 'asia-northeast1-test-pg-yukihira-280008.cloudfunctions.net'
    port = nil
    path = `/sapSendMail?name=#{name}&login_link=#{login_link}&email=#{email}&password_init=#{password_init}&api_key=#{api_key}`
    # path = '/sapSendMail'
    # params = {
    #   university_name: university_name,
    #   faculty_name: faculty_name,
    #   department_name: department_name,
    #   name: name,
    #   login_link: login_link,
    #   email: email,
    #   password_init: password_init,
    #   end_datetime: end_datetime,
    #   view_end_datetime: view_end_datetime,
    #   api_key: api_key
    # }

    uri = URI.parse(url)
    logger.debug(uri)
    https = Net::HTTP.new(host, port)
    req = Net::HTTP::Get.new(path)
    # req = Net::HTTP::Post.new(path)
    # req.set_form_data(params: params.to_json)
    res = https.request(req)
    logger.debug(res)
  end

  def send_student
    current_admin.student.each do |student|
      send_mail(student, current_admin, 'students')
      # NotificationMailer.send_login_info(student, current_admin, 'sap/students/devise/sessions').deliver
    end
  end

  def send_laboratory
    current_admin.laboratory.each do |laboratory|
      send_mail(laboratory, current_admin, 'laboratories')
      # NotificationMailer.send_login_info(laboratory, current_admin, 'sap/laboratories/devise/sessions').deliver
    end
  end
end
