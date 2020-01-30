class Admins::HomeController < Admins::ApplicationController
  skip_before_action :check_release_flag!
  
  def index
  end
end
