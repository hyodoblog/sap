module AdminActions
 #以下extendは必須
  extend ActiveSupport::Concern

  def init_setup_check!
    if current_admin.init_setup_flag
      flash[:alert] = '初期設定済みなためアクセスできません'
      redirect_to(admins_root_path)
    end
  end

  def release_false_check!
    unless current_admin.release_flag
      flash[:alert] = 'SAP稼動中はアクセスできません'
      redirect_to(admins_root_path)
    end
  end

  def release_true_check!
    if current_admin.release_flag
      flash[:alert] = 'SAP停止中はアクセスできません'
      redirect_to(admins_root_path)
    end
  end

  def datetime_check!
    now_datetime = Time.zone.now
    unless current_admin.start_datetime <= now_datetime && current_admin.end_datetime >= now_datetime
      flash[:alert] = '稼動期間外なためアクセスできません'
      redirect_to(admins_root_path)
    end
  end

  def end_check!
    if current_admin.end_flag
      flash[:alert] = 'SAPが終了しました。次の稼動をご希望の場合は初期化を行って下さい！'
      redirect_to(admins_root_path)
    end
  end
end