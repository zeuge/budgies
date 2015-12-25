require "rails_helper"

describe ColorsController do
  render_views

  let(:color) { create :color }
  let(:json)  { JSON.parse response.body, symbolize_names: true }

  let(:valid_params)    { attributes_for :color, name: "new name" }
  let(:invalid_params)  { attributes_for :color, name: nil }

  # ============================================================================
  # index
  #
  describe "GET colors.json" do
    it "returns the list of colors" do
      color
      get :index, format: :json

      expect(response).to be_success
      expect(json[0][:id]).to eq color.id
      expect(json[0][:name]).to eq color.name
    end
  end

  # ============================================================================
  # show
  #
  describe "GET /colors/:id.json" do
    it "returns one color with valid id" do
      color
      get :show, format: :json, id: 1

      expect(response).to be_success
      expect(json[:id]).to eq color.id
      expect(json[:name]).to eq color.name
    end

    it "returns errors with invalid id" do
      color
      get :show, format: :json, id: 10

      expect(response).to be_not_found
      expect(json[:error]).to eq "Couldn't find Color with 'id'=10"
    end
  end

  # ============================================================================
  # create
  #
  describe "POST /colors.json" do
    context "with valid params" do
      it "returns http success" do
        post :create, format: :json, color: valid_params
        expect(response).to be_success
      end

      it "creates new Color" do
        expect {
          post :create, format: :json, color: valid_params
        }.to change(Color, :count).by(1)
      end
    end

    it "returns errors with invalid params" do
      post :create, format: :json, color: invalid_params

      expect(response.status).to eq 422
      expect(json[:errors][:name]).to include "can't be blank"
    end
  end

  # ============================================================================
  # update
  #
  describe "PUT /colors/:id.json" do
    it "updates the requested color whith valid params" do
      color
      put :update, format: :json, id: color.to_param, color: valid_params

      expect(response).to be_success
      color.reload
      expect(color.name).to eq valid_params[:name]
    end

    it "returns errors with invalid params" do
      color
      put :update, format: :json, id: color.to_param, color: invalid_params

      expect(response.status).to eq 422
      expect(json[:errors][:name]).to include "can't be blank"
    end
  end

  # ============================================================================
  # destroy
  #
  describe "DELETE /colors/:id.json" do
    it "deletes the requested color with valid id" do
      color
      delete :destroy, format: :json, id: 1

      expect(response).to be_success
      expect(Color.where id: 1).to be_empty
    end

    it "returns errors with invalid id" do
      color
      delete :destroy, format: :json, id: 10

      expect(response).to be_not_found
      expect(json[:error]).to eq "Couldn't find Color with 'id'=10"
    end
  end

end
