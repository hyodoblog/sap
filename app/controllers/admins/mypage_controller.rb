class Admins::MypageController < Admins::ApplicationController
  skip_before_action :release_true_check!
  skip_before_action :end_check!, only: [:index]
  
  def show
  end
end
