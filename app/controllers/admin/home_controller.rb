class Admin::HomeController < Admin::ApplicationController
  def index
    begin
      @config = Config.find(current_user.id)
      @laboratories = Laboratory.all()
      @students = Student.all()
    rescue ActiveRecord::RecordNotFound => exception
      @config = nil
    end
  end
end
