class Sap::ApplicationController < ApplicationController
  include SapActions
  before_action :sap_key_check!, :end_flag_check!
end
