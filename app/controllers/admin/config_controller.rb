class Admin::ConfigController < Admin::ApplicationController
  def show
  end

  def edit
  end

  def update
    if current_user_params[:start_datetime] >= current_user_params[:end_datetime]
      flash[:error_messages] = ['希望終了日を希望開始日より後に設定して下さい！']
      redirect_back(fallback_location: root_path) and return
    elsif current_user_params[:end_datetime] >= current_user_params[:view_end_datetime]
      flash[:error_messages] = ['閲覧期間を希望終了日より後に設定して下さい！']
      redirect_back(fallback_location: root_path) and return
    end
    current_user.attributes(config_params)
    if current_user.save(context: :init_setup)
      flash[:notice] = '設定を編集しました'
      redirect_to(admin_config_show_path)
    else
      flash[:error_messages] = current_user.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def current_user_params
    params.require(:user).permit(:university_name, :faculty_name, :department_name,
                                 :contact_email, :max_choice_student, :max_choice_laboratory,
                                 :max_confirm_student, :start_datetime, :end_datetime,
                                 :view_end_datetime)
  end
end
