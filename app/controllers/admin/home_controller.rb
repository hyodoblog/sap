class Admin::HomeController < Admin::ApplicationController
  skip_before_action :check_release_flag!
  
  def index
    if current_user.init_setup_flag
      @laboratories = Laboratory.where(user_id: current_user.id)
      @students = Student.where(user_id: current_user.id)
    end
  end
end
