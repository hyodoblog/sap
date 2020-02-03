class Admins::ApplicationController < ApplicationController
  include AdminActions
  before_action :authenticate_admin!
  before_action :release_true_check!
  before_action :end_check!
end
