class Sap::ApplicationController < ApplicationController
  include SapActions
  before_action :sap_key_check!, :sap_end_check!
end
