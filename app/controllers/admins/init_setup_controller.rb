class Admins::InitSetupController < Admins::ApplicationController
  before_action :init_setup_check!

  def first
    current_admin = flash[:current_admin] if !flash[:current_admin].nil?
  end

  def first_setup
    if user_params[:start_datetime] >= user_params[:end_datetime]
      flash[:error_messages] = ['希望終了日を希望開始日より後に設定して下さい！']
      redirect_back(fallback_location: root_path) and return
    elsif user_params[:end_datetime] >= user_params[:view_end_datetime]
      flash[:error_messages] = ['閲覧期間を希望提出期間より遅く設定して下さい！']
      redirect_back(fallback_location: root_path) and return
    end

    current_admin.attributes = user_params
    if current_admin.save
      flash[:notice] = "ステップ1完了　入力した設定を保存しました"
      redirect_to(admins_init_setup_second_path)
    else
      flash[:current_admin] = user_params
      flash[:error_messages] = current_admin.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def first_skip
    if current_admin.university_name.nil?
      current_admin.attributes = user_params_setup
      current_admin.save(context: :info)
    end
    redirect_to(admins_init_setup_second_path)
  end

  def second
  end

  def second_setup_csv
    # csv file ckeck
    unless params[:csv_file_laboratory] || params[:csv_file_student]
      error_messages = ['最低でもどちらか一方のcsvファイルを選択してください']
      flash[:error_messages] = error_messages
      redirect_back(fallback_location: root_path) and return
    end

    # csv import
    flash_notice_messages = []
    admin_id = current_admin.id
    # student
    if params[:csv_file_student]
      begin
        current_admin.student.csv_import(csv_file_student_params, admin_id)
      rescue ActiveRecord::RecordNotUnique
        flash[:error_messages] = ['研究室データをもう一度確認して下さい',
                                  'すでに登録されているEメールが存在します',
                                  '別のアカウントで登録されているEメールの可能性があります',
                                  'その場合は別のEメールを使用するか、当サービスの運営者までお問い合わせください！']
        redirect_back(fallback_location: root_path) and return
      rescue => e
        flash[:error_messages] = ['学生データをもう一度確認下さい', e.message]
        redirect_back(fallback_location: root_path) and return
      end
      flash_notice_messages.push('学生のcsvファイルのインポート成功')
    end
    # laboratory
    if params[:csv_file_laboratory]
      begin
        current_admin.laboratory.csv_import(csv_file_laboratory_params, admin_id)
      rescue ActiveRecord::RecordNotUnique
        flash[:error_messages] = ['研究室データをもう一度確認して下さい',
                                  'すでに登録されているEメールが存在します',
                                  '別のアカウントで登録されているEメールの可能性があります',
                                  'その場合は別のEメールを使用するか、当サービスの運営者までお問い合わせください！']
        redirect_back(fallback_location: root_path) and return
      rescue => e
        flash[:notices] = flash_notice_messages
        flash[:error_messages] = ['研究室データをもう一度確認下さい', e.message]
        redirect_back(fallback_location: root_path) and return
      end
      flash_notice_messages.push('研究室のcsvファイルのインポート成功')
    end
    redirect_to(admins_init_setup_second_skip_path)
  end

  def second_setup_excel
    # file ckeck
    unless xlsx_file_params
      error_messages = ['ファイルを選択してください']
      flash[:error_messages] = error_messages
      redirect_back(fallback_location: root_path) and return
    end
    file = Roo::Spreadsheet.open(xlsx_file_params.path)
    admin_id = current_admin.id
    file.each_with_pagename do |name, sheet|
      case name
      when '学生' then
        begin
          current_admin.student.xlsx_import(sheet, admin_id)
        rescue ActiveRecord::RecordNotUnique
          flash[:error_messages] = ['学生データをもう一度確認して下さい',
                                    'すでに登録されているEメールが存在します',
                                    '別のアカウントで登録されているEメールの可能性があります',
                                    'その場合は別のEメールを使用するか、当サービスの運営者までお問い合わせください！']
          redirect_back(fallback_location: root_path) and return
        rescue => e
          flash[:error_messages] = ['学生データをもう一度確認して下さい', e.message]
          redirect_back(fallback_location: root_path) and return
        end
      when '研究室' then
        begin
          current_admin.laboratory.xlsx_import(sheet, admin_id)
        rescue ActiveRecord::RecordNotUnique
          flash[:error_messages] = ['研究室データをもう一度確認して下さい',
                                    'すでに登録されているEメールが存在します',
                                    '別のアカウントで登録されているEメールの可能性があります',
                                    'その場合は別のEメールを使用するか、当サービスの運営者までお問い合わせください！']
          redirect_back(fallback_location: root_path) and return
        rescue => e
          flash[:error_messages] = ['研究室データをもう一度確認して下さい', e.message]
          redirect_back(fallback_location: root_path) and return
        end
      end
    end
    current_admin.update_attributes(init_setup_flag: true)
    flash[:notice] = 'エクセルデータのインポートに成功しました'
    redirect_to(admins_root_path)
  end

  def second_skip
    current_admin.update_attributes(init_setup_flag: true)
    flash[:notice] = "初期設定完了"
    redirect_to(admins_root_path)
  end

  private

  def user_params
    params[:admin][:sap_key] = Admin.generate_sap_key
    params.require(:admin).permit(:sap_key, :university_name, :faculty_name, :department_name,
                                 :contact_email, :max_choice_student, :max_choice_laboratory,
                                 :start_datetime, :end_datetime,
                                 :view_end_datetime)
  end

  def user_params_setup
    now_datetime = DateTime.now
    {
        sap_key: Admin.generate_sap_key, university_name: '〇〇大学',
        faculty_name: '', department_name: '', contact_email: '',
        max_choice_student: 1, max_choice_laboratory: 1,
        start_datetime: now_datetime, end_datetime: now_datetime + 1.days, view_end_datetime: now_datetime + 2.days
    }
  end

  def csv_file_laboratory_params
    params.require(:csv_file_laboratory)
  end

  def csv_file_student_params
    params.require(:csv_file_student)
  end

  def xlsx_file_params
    params.require(:xlsx_file)
  end

  def check_init_setup_flag
    if current_admin.init_setup_flag
      redirect_to(admins_root_path)
    end
  end
end
