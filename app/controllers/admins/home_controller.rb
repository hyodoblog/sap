class Admins::HomeController < Admins::ApplicationController
  skip_before_action :release_true_check!
  skip_before_action :end_check!

  def index
  end
end
