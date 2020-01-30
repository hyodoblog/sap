class Admins::ConfigController < Admins::ApplicationController
  def show
  end

  def edit
  end

  def update
    if current_admin_params[:start_datetime] >= current_admin_params[:end_datetime]
      flash[:error_messages] = ['希望終了日を希望開始日より後に設定して下さい！']
      redirect_back(fallback_location: root_path) and return
    elsif current_admin_params[:end_datetime] >= current_admin_params[:view_end_datetime]
      flash[:error_messages] = ['閲覧期間を希望終了日より後に設定して下さい！']
      redirect_back(fallback_location: root_path) and return
    end
    current_admin.attributes = current_admin_params
    if current_admin.save(context: :init_setup)
      flash[:notice] = '設定を編集しました'
      redirect_to(admins_config_show_path)
    else
      flash[:error_messages] = current_admin.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def current_admin_params
    params.require(:admin).permit(:university_name, :faculty_name, :department_name,
                                  :contact_email, :max_choice_student, :max_choice_laboratory,
                                  :max_confirm_student, :start_datetime, :end_datetime,
                                  :view_end_datetime, :login_info_email_flag)
  end
end
