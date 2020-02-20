class Admins::NoticesController < Admin::ApplicationController
  skip_before_action :release_true_check!

  def index
  end

  def create

  end
end
