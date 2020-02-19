class Admins::InitController < Admins::ApplicationController
  skip_before_action :release_true_check!, only: [:sap]
  skip_before_action :end_check!, only: [:sap]

  def all
    current_admin.student.destroy_all
    current_admin.laboratory.destroy_all
    flash[:notice] = '全学生・研究室を削除しました'
    redirect_to(admins_root_path)
  end

  def laboratory
    current_admin.laboratory.destroy_all
    flash[:notice] = '全研究室を削除しました'
    redirect_to(admins_root_path)
  end

  def student
    current_admin.student.destroy_all
    flash[:notice] = '全学生を削除しました'
    redirect_to(admins_root_path)
  end

  def sap
    current_admin.student.destroy_all    if current_admin.student.present?
    current_admin.laboratory.destroy_all if current_admin.laboratory.present?
    current_admin.update_attributes(admin_init_params)
    flash[:notice] = '初期化が完了しました'
    redirect_to(admins_root_path)
  end

  private

  def admin_init_params
    now_datetime = DateTime.now
    {
        sap_key: Admin.generate_sap_key, university_name: '〇〇大学',
        faculty_name: '', department_name: '', contact_email: '',
        max_choice_student: 1, max_choice_laboratory: 1, max_confirmed_student: '',
        start_datetime: now_datetime, end_datetime: now_datetime + 1.days, view_end_datetime: now_datetime + 2.days,
        init_setup_flag: false, release_flag: false, start_flag: false, end_flag: false, login_info_email_flag: false,
        confirmation_notice_flag: false, end_notice_flag: false, view_end_notice_flag: false
    }
  end
end
