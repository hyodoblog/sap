class Admin::MypageController < Admin::ApplicationController  
  def show
    @user = User.find(current_user.id)
  end
end
