module AdminActions
 #以下extendは必須
  extend ActiveSupport::Concern

  def release_flag_true_check!
    unless current_admin.release_flag
      flash[:alert] = 'SAP稼動中はアクセスできません'
      redirect_to(admins_root_path)
    end
  end

  def release_flag_false_check!
    unless current_admin.release_flag
      flash[:alert] = 'SAP稼働中のみアクセス可能です'
      redirect_to(admins_root_path)
    end
  end

  def sap_datetime_check!
    now_datetime = Time.zone.now
    logger.debug(now_datetime)
    unless current_admin.start_datetime <= now_datetime && current_admin.end_datetime >= now_datetime
      flash[:alert] = '稼動期間外なためアクセスできません'
      redirect_to(admins_root_path)
    end
  end
end