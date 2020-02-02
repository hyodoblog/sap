class Admins::HomeController < Admins::ApplicationController
  skip_before_action :release_true_check!, :end_check!

  def index
  end
end
