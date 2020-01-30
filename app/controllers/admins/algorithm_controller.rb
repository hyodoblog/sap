class Admins::AlgorithmController < Admins::ApplicationController
  def manual
    redirect_to(admin_root)
  end
end
