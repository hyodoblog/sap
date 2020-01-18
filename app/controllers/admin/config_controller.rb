class Admin::ConfigController < Admin::ApplicationController
  before_action :set_config

  def edit
    @config.start_datetime = @config.start_datetime.to_s(:datetime_jp)
    @config.end_datetime = @config.end_datetime.to_s(:datetime_jp)
    @config.view_end_datetime = @config.view_end_datetime.to_s(:datetime_jp)
  end

  def update
    if config_params[:end_datetime] >= config_params[:view_end_datetime]
      flash[:error_messages] = ['閲覧期間を希望提出期間より遅く設定して下さい！']
      redirect_back(fallback_location: root_path) and return
    end
    if @config.update(config_params)
      flash[:notice] = '設定を編集しました'
      redirect_to(admin_config_edit_path)
    else
      flash[:error_messages] = @config.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_config
    @config = Config.find_by(user_id: current_user.id)
  end

  def config_params
    params.require(:config).permit(:user_id, :university_name, :faculty_name, :department_name,
                                   :contact_email, :max_choice_student, :max_choice_laboratory,
                                   :start_datetime, :end_datetime, :view_end_datetime)
  end
end
