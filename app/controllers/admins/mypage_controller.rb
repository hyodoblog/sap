class Admin::MypageController < Admin::ApplicationController  
  def show
    @user = Admin.find(current_user.id)
  end
end
