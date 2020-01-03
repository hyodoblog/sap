class Admin::InitSetupController < Admin::ApplicationController
  before_action :check_init_setup_flag

  def first
    begin
      @config = Config.find(current_user.config.id)
    rescue NoMethodError => exception
      @config = Config.new()
    end
  end

  def first_setup
    config = Config.new(config_params)
    if config.save
      flash[:notice] = "ステップ1完了"
      redirect_to admin_init_setup_second_path
    else
      flash[:error_messages] = config.errors.full_messages
      redirect_back fallback_location: root_path
    end
  end

  def first_skip
    redirect_to admin_init_setup_second_path
  end

  def second
  end

  def second_setup
    # csv file ckeck
    unless params[:csv_file_laboratory] || params[:csv_file_student]
      error_messages = ['最低でもどちらか一方のcsvファイルを選択してください']
      flash[:error_messages] = error_messages
      redirect_back fallback_location: root_path and return
    end

    # csv import
    flash_notice_messages = []
    user_id = current_user.id
    # laboratory
    if params[:csv_file_laboratory]
      csv_import_flag, error_messages = Laboratory.csv_import(csv_file_laboratory_params, user_id)
      if csv_import_flag
        flash_notice_messages.push('研究室のcsvファイルのインポート成功')
      else
        flash[:error_messages] = ['研究室データをもう一度確認下さい'] | error_messages
        redirect_back fallback_location: root_path and return
      end
    end
    # student
    if params[:csv_file_student]
      csv_import_flag, error_messages = Student.csv_import(csv_file_student_params, user_id)
      if csv_import_flag
        flash_notice_messages.push('学生のcsvファイルのインポート成功')
      else
        laboratories = Laboratory.where(admin_id: current_user.config.id)
        flash[:error_messages] = ['学生データをもう一度確認下さい'] | error_messages
        redirect_back fallback_location: root_path and return
      end
    end
    redirect_to admin_mypage_path	
  end

  def second_skip
    config = Config.find(current_user.config.id)
    config.update(init_setup_flag: true)
    redirect_to admin_mypage_path	
  end

  private

  def config_params
    params.require(:config).permit(:user_id, :sap_key, :university_name, :faculty_name, :department_name,
                                   :contact_email, :max_choice_student, :max_choice_laboratory,
                                   :start_datetime, :end_datetime, :view_end_datetime)
    
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
        redirect_to admin_mypage_path
      end
    rescue NoMethodError => exception
      # 何もしない
    end
  end
end
