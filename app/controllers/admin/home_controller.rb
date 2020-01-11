class Admin::HomeController < Admin::ApplicationController
  skip_before_action :check_release_flag!
  
  def index
    begin
      @config = Config.find_by(user_id: current_user.id)
      @laboratories = Laboratory.all()
      @students = Student.all()
    rescue ActiveRecord::RecordNotFound => exception
      @config = nil
    end
  end
end
