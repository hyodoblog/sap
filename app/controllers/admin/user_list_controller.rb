class Admin::UserListController < Admin::ApplicationController
  def index
    begin
      config = Config.find(current_user.id)
      @init_flag = config.init_setup_flag
    rescue ActiveRecord::RecordNotFound => exception
      @init_flag = false
    end
  end
end
