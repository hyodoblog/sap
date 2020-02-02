class Admins::ApplicationController < ApplicationController
  include AdminActions
  before_action :authenticate_admin!
end
