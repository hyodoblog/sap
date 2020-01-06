class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :check_release_flag!

  private

  def check_release_flag!
    begin
      @config = Config.find_by(user_id: current_user.id)
      if @config.release_flag
        redirect_to admin_root_path
      end
    rescue
      
    end
  end
end
