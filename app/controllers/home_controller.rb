class HomeController < ApplicationController
  before_action :set_config

  def index
  end

  private

  def set_config
    begin
      @config = Config.find_by(user_id: current_user.id)
    rescue
      @config = nil
    end
  end
end
