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

  def sap_end_check!
    if current_admin.end_flag
      flash[:notice] = 'SAPの閲覧期限が'
    end
  end
end