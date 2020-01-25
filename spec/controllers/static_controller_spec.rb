require 'rails_helper'

RSpec.describe StaticController, type: :controller do

  describe "GET #privacy" do
    it "returns http success" do
      get :privacy
      expect(response).to have_http_status(:success)
    end
  end

end
