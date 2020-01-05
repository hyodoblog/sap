class HomeController < ApplicationController
  before_action :redirect_admin_path, if: -> { user_signed_in?	}

  def index
  end

  private

  def redirect_admin_path
    redirect_to admin_root_path
  end
end
