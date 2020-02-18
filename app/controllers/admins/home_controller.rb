class Admins::HomeController < Admins::ApplicationController
  skip_before_action :release_true_check!
  skip_before_action :end_check!, only: [:index]
  before_action :release_false_check!, only: [:choice_list]

  def index
  end

  def choice_list
  end
end
