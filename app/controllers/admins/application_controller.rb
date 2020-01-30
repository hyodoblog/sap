class Admins::ApplicationController < ApplicationController
  before_action :authenticate_admin!
  before_action :check_release_flag!

  private

  def check_release_flag!
    if current_admin.release_flag
      redirect_to(admins_root_path)
    end
  end
end
