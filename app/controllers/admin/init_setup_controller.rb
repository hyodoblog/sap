class Admin::InitSetupController < Admin::ApplicationController
  before_action :check_init_setup_flag

  def first
    current_user = flash[:current_user] if !flash[:current_user].nil?
  end

  def first_setup
    if user_params[:start_datetime] >= user_params[:end_datetime]
      flash[:error_messages] = ['希望終了日を希望開始日より後に設定して下さい！']
      redirect_back(fallback_location: root_path) and return
    elsif user_params[:end_datetime] >= user_params[:view_end_datetime]
      flash[:error_messages] = ['閲覧期間を希望提出期間より遅く設定して下さい！']
      redirect_back(fallback_location: root_path) and return
    end

    current_user.attributes = user_params
    if current_user.save
      flash[:notice] = "ステップ1完了　入力した設定を保存しました"
      redirect_to(admin_init_setup_second_path)
    else
      flash[:current_user] = user_params
      flash[:error_messages] = current_user.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def first_skip
    if current_user.university_name.nil?
      current_user.attributes = user_params_setup
      current_user.save(context: :init_setup)
    end
    redirect_to(admin_init_setup_second_path)
  end

  def second
  end

  def second_setup
    # csv file ckeck
    unless params[:csv_file_laboratory] || params[:csv_file_student]
      error_messages = ['最低でもどちらか一方のcsvファイルを選択してください']
      flash[:error_messages] = error_messages
      redirect_back(fallback_location: root_path) and return
    end

    # csv import
    flash_notice_messages = []
    user_id = current_user.id
    # laboratory
    if params[:csv_file_laboratory]
      begin
        Laboratory.csv_import(csv_file_laboratory_params, user_id)
      rescue => e
        flash[:error_messages] = ['研究室データをもう一度確認下さい', e.message]
        redirect_back(fallback_location: root_path) and return
      end
      flash_notice_messages.push('研究室のcsvファイルのインポート成功')
    end
    # student
    if params[:csv_file_student]
      begin
        Student.csv_import(csv_file_student_params, user_id)
      rescue => e
        flash[:notices] = flash_notice_messages
        flash[:error_messages] = ['学生データをもう一度確認下さい', e.message]
        redirect_back(fallback_location: root_path) and return
      end
      flash_notice_messages.push('学生のcsvファイルのインポート成功')
    end
    redirect_to(admin_init_setup_second_skip_path)
  end

  def second_skip
    current_user.update_attributes(init_setup_flag: true)
    flash[:notice] = "初期設定完了"
    redirect_to(admin_root_path)
  end

  private

  def user_params
    params[:user][:sap_key] = User.generate_sap_key
    params.require(:user).permit(:sap_key, :university_name, :faculty_name, :department_name,
                                 :contact_email, :max_choice_student, :max_choice_laboratory,
                                 :max_confirmed_student, :start_datetime, :end_datetime, :view_end_datetime)
  end

  def user_params_setup
    now_datetime = DateTime.now
    {
        sap_key: User.generate_sap_key, university_name: '〇〇大学',
        faculty_name: '', department_name: '', contact_email: '',
        max_choice_student: 1, max_choice_laboratory: 1, max_confirmed_student: '',
        start_datetime: now_datetime, end_datetime: now_datetime + 1.days, view_end_datetime: now_datetime + 2.days
    }
  end

  def csv_file_laboratory_params
    params.require(:csv_file_laboratory)
  end

  def csv_file_student_params
    params.require(:csv_file_student)
  end

  # 初期設定が完了している管理者はアクセス拒否
  def check_init_setup_flag
    begin
      if current_user.config.init_setup_flag
        redirect_to(admin_root_path)
      end
    rescue NoMethodError => exception
      # 何もしない
    end
  end
end
