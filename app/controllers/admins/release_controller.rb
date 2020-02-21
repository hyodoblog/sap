class Admins::ReleaseController < Admins::ApplicationController
  before_action :release_true_check!, only: [:on]
  before_action :release_false_check!, only: [:off]

  def on
    # エラーチェック
    # 学生または研究室を登録しているかチェック
    if current_admin.student.length == 0 || current_admin.laboratory.length == 0
      flash[:alert] = '学生または研究室を追加してください'
      redirect_to(admins_root_path) and return
    end
    # 研究室の最大配属人数のチェック
    if laboratory_total_max_num_check?
      flash[:alert] = "研究室の最大配属人数の合計が学生数より少ないです。誰か一人無制限にするか、最大配属人数の調整をしてください"
      redirect_to(admins_root_path) and return
    end

    if current_admin.login_info_email_flag && !current_admin.start_flag
      current_admin.laboratory.each do |laboratory|
        NotificationMailer.send_login_info(laboratory, current_admin, 'sap/laboratories/devise/sessions').deliver
      end
      current_admin.student.each do |student|
        NotificationMailer.send_login_info(student, current_admin, 'sap/students/devise/sessions').deliver
      end
    end
    current_admin.update_attributes!(release_flag: true, start_flag: true)
    flash[:notice] = 'SAPのログインページを発行しました'
    redirect_to(admins_root_path)
  end

  def off
    current_admin.update_attributes(release_flag: false)
    flash[:notice] = 'SAPの稼働を一時停止しました'
    redirect_to(admins_root_path)
  end

  def force_termination
    current_admin.assign_list.destroy_all       if current_admin.assign_list.present?
    current_admin.student_choice.destroy_all    if current_admin.student_choice.present?
    current_admin.laboratory_choice.destroy_all if current_admin.laboratory_choice.present?
    current_admin.student_rate.destroy_all      if current_admin.student_rate.present?
    current_admin.laboratory_rate.destroy_all   if current_admin.laboratory_rate.present?
    current_admin.student.each do |student|
      student.update_attributes(user_force_init_param)
    end
    current_admin.laboratory.each do |laboratory|
      laboratory.update_attributes(user_force_init_param)
    end
    current_admin.update_attributes(release_flag: false, start_flag: false)
    flash[:notice] = "SAPを強制終了させました。またの稼動をお待ちしております！"
    redirect_to(admins_root_path)
  end

  private

  def laboratory_total_max_num_check?
    total_assign_num = 0
    students_num = current_admin.student.length
    current_admin.laboratory.each do |laboratory|
      return false if laboratory.max_num.nil?
      total_assign_num += laboratory.max_num
      return false if total_assign_num >= students_num
    end
    return true
  end

  def user_force_init_param
    {
      latest_rate: 0,
      sign_in_count: 0,
      current_sign_in_at: '',
      last_sign_in_at: '',
      current_sign_in_ip: '',
      last_sign_in_ip: ''
    }
  end
end
