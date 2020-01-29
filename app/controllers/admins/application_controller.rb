class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :check_release_flag!

  private

  def check_release_flag!
    if current_user.release_flag
      redirect_to(admin_root_path)
    end
  end
end
