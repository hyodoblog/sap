class Admins::MypageController < Admins::ApplicationController
  def show
    @user = Admin.find(current_admin.id)
  end
end
