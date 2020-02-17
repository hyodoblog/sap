class ApplicationController < ActionController::Base
  # ログイン後のページ遷移
  def after_sign_in_path_for(resource)
    case resource_name
    when :admin then
      admins_root_path
    when :student then
      students_root_path
    when :laboratory then
      laboratories_root_path
    end
  end
end
