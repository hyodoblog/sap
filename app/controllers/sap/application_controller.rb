class Sap::ApplicationController < ApplicationController
  include UserAuthChecks
  include SapActions
  before_action :sap_key_check!
  before_action :access_check!
end
