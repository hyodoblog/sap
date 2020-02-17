class Admins::RatesController < Admins::ApplicationController
  skip_before_action :release_true_check!
  skip_before_action :end_check!
  before_action      :release_false_check!

  def index
  end
end
