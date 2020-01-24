class Admin::AlgorithmController < Admin::ApplicationController
  def manual
    redirect_to(admin_root)
  end
end
