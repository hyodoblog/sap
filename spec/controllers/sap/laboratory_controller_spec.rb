require 'rails_helper'

RSpec.describe Sap::LaboratoryController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #choice" do
    it "returns http success" do
      get :choice
      expect(response).to have_http_status(:success)
    end
  end

end
