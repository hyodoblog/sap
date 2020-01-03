require 'rails_helper'

RSpec.describe Admin::InitSetupController, type: :controller do

  describe "GET #first" do
    it "returns http success" do
      get :first
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #first_setup" do
    it "returns http success" do
      get :first_setup
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #second" do
    it "returns http success" do
      get :second
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #second_setup" do
    it "returns http success" do
      get :second_setup
      expect(response).to have_http_status(:success)
    end
  end

end
