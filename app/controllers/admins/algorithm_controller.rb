class Admins::AlgorithmController < Admins::ApplicationController
  skip_before_action :release_true_check!
  before_action :release_false_check!
  before_action :datetime_check!
  include Algorithm

  def manual
    algo_update(current_admin)
    flash[:notice] = '配属一覧を更新しました'
    redirect_to(assign_lists_path(current_admin.sap_key))
  end
end
