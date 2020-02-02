class Admins::ApplicationController < ApplicationController
  include AdminActions
  before_action :authenticate_admin!, :release_true_check!, :end_check!
end
