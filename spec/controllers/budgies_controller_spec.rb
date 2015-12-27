require "rails_helper"

describe BudgiesController do
  render_views

  let(:budgie) { create :budgie }
  let(:json)  { JSON.parse response.body, symbolize_names: true }

  let(:valid_params)    { attributes_for :budgie, name: "new name" }
  let(:invalid_params)  { attributes_for :budgie, name: nil }

  # ============================================================================
  # index
  #
  describe "GET budgies.json" do
    it "returns the list of budgies" do
      budgie
      get :index, format: :json

      expect(response).to be_success

      expect(json[0][:id]).to eq budgie.id
      expect(json[0][:name]).to eq budgie.name
      expect(json[0][:gender]).to eq budgie.gender
      expect(json[0][:color_id]).to eq budgie.color_id
      expect(json[0][:age]).to eq budgie.age
      expect(json[0][:tribal]).to eq budgie.tribal
      expect(json[0][:father_id]).to eq budgie.father_id
      expect(json[0][:mother_id]).to eq budgie.mother_id
    end
  end

  # ============================================================================
  # show
  #
  describe "GET /budgies/:id.json" do
    it "returns one budgie with valid id" do
      budgie
      get :show, format: :json, id: 1

      expect(response).to be_success
      expect(json[:id]).to eq budgie.id
      expect(json[:name]).to eq budgie.name
      expect(json[:gender]).to eq budgie.gender
      expect(json[:color_id]).to eq budgie.color_id
      expect(json[:age]).to eq budgie.age
      expect(json[:tribal]).to eq budgie.tribal
      expect(json[:father_id]).to eq budgie.father_id
      expect(json[:mother_id]).to eq budgie.mother_id
    end

    it "returns errors with invalid id" do
      budgie
      get :show, format: :json, id: 10

      expect(response).to be_not_found
      expect(json[:error]).to eq "Couldn't find Budgie with 'id'=10"
    end
  end

  # ============================================================================
  # create
  #
  describe "POST /budgies.json" do
    context "with valid params" do
      it "returns http success" do
        post :create, format: :json, budgie: valid_params
        expect(response).to be_success
      end

      it "creates a new Budgie" do
        expect {
          post :create, format: :json, budgie: valid_params
        }.to change(Budgie, :count).by(1)
      end
    end

    it "returns errors with invalid params" do
      post :create, format: :json, budgie: invalid_params

      expect(response.status).to eq 422
      expect(json[:errors][:name]).to include "can't be blank"
    end
  end

  # ============================================================================
  # update
  #
  describe "PUT /budgies/:id.json" do
    it "updates the requested budgie whith valid params" do
      budgie
      put :update, format: :json, id: budgie.to_param, budgie: valid_params

      expect(response).to be_success
      budgie.reload
      expect(budgie.name).to eq valid_params[:name]
    end

    it "returns errors with invalid params" do
      budgie
      put :update, format: :json, id: budgie.to_param, budgie: invalid_params

      expect(response.status).to eq 422
      expect(json[:errors][:name]).to include "can't be blank"
    end
  end

  # ============================================================================
  # destroy
  #
  describe "DELETE /budgies/:id.json" do
    it "deletes the requested budgie with valid id" do
      budgie
      delete :destroy, format: :json, id: 1

      expect(response).to be_success
      expect(Budgie.where id: 1).to be_empty
    end

    it "returns errors with invalid id" do
      budgie
      delete :destroy, format: :json, id: 10

      expect(response).to be_not_found
      expect(json[:error]).to eq "Couldn't find Budgie with 'id'=10"
    end
  end
end
