require "rails_helper"

describe MainController do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status :success
    end
  end

end