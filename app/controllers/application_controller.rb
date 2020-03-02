class ApplicationController < ActionController::Base

  protected

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

  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
    when :admin then
      root_path
    when :student then
      new_student_session_path(@sap_key)
    when :laboratory then
      new_laboratory_session_path(@sap_key)
    end
  end
end
