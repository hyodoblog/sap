module SapActions
 #以下extendは必須
  extend ActiveSupport::Concern

  def sap_key_check!
    if params[:sap_key].present? && Admin.find_by(sap_key: params[:sap_key]).present?
      @admin = Admin.find_by(sap_key: params[:sap_key])
      @sap_key = params[:sap_key]
    else
      flash[:alert] = '管理者情報の取得に失敗しました'
      redirect_to(root_path)
    end
  end

  def session_check!
    if !@admin.start_flag
      flash[:alert] = 'SAPが稼動してないためアクセスできません'
    elsif @admin.start_datetime >= Time.now()
      flash[:alert] = "SAPの稼動が開始されていません。#{@admin.start_datetime.to_s(:datetime_jp)}までお待ち下さい！"
    elsif @admin.end_flag
      flash[:alert] = 'SAPの稼動が終了しています。よい配属になっていることを心から願っております。'
    else
      return
    end
    redirect_to(root_path)
  end

  def access_check!
    if current_student.present?
      return ( sap_login_check!(current_student) ||
               sap_end_check!(current_student) ||
               sap_end_check!(current_student) ||
               sap_end_choice_check!(current_student) )
    elsif current_laboratory.present?
      return ( sap_login_check!(current_laboratory) ||
               sap_end_check!(current_laboratory) ||
               sap_end_check!(current_laboratory) ||
               sap_end_choice_check!(current_laboratory) )
    else
      return error_redirect!
    end
  end

  def assign_list_access_check!
    if current_admin.present?
    elsif current_student.present?
    elsif current_laboratory.present?
    else
      return error_redirect!
    end
  end

  def sap_login_check!(current_user)
    if start_flag_check?(current_user)
      flash[:alert] = 'SAPが起動していないため、ログインできません。'
    elsif start_date_check?(current_user)
      flash[:alert] = 'SAPの稼動期間外なため、ログインできません。'
    else
      return
    end
    redirect_to(root_path)
  end

  def sap_end_check!(current_user)
    if end_flag_check?(current_user) || veiw_end_check?(current_user)
      flash[:alert] = 'SAPが終了したためアクセスできません。配属された研究室で頑張って下さい！'
      redirect_to(root_paht)
    end
  end

  def sap_end_choice_check!(current_user)
    if end_choice_check?(current_user)
      flash[:alert] = '希望提出期間が過ぎたためアクセスできません。自身の配属結果をご覧ください！'
      redirect_to(assin_lists_path(@sap_key))
    end
  end

  def error_redirect!
    flash[:alert] = 'アクセスチェックでエラーが発生しました。当サービスの運営者にお問い合わせ下さい！'
    redirect_to(root_path)
  end

  private

  def start_flag_check?(current_user)
    return true if !current_user.admin.start_flag
    return false
  end

  def end_flag_check?(current_user)
    return true if current_user.admin.end_flag
    return false
  end

  def start_date_check?(current_user)
    now_time = Time.now()
    start_datetime = current_user.admin.start_datetime
    return true if start_datetime >= now_time
    return false
  end

  def veiw_end_check?(current_user)
    now_time = Time.now()
    view_end_datetime = current_user.admin.view_end_datetime
    return true if view_end_datetime <= now_time
    return false
  end

  def end_choice_check?(current_user)
    now_time = Time.now()
    end_datetime = current_user.admin.end_datetime
    return true if end_datetime <= now_time
    return false
  end
end