class HomeController < ApplicationController
  include UserAuthChecks
  before_action :login_check

  def index
  end

  def privacy
  end
end
