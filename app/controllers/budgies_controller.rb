class BudgiesController < ApplicationController
  respond_to :json
  before_action :set_budgie, only: [:show, :update, :destroy, :descendents, :ancestors]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {error: exception.message}, status: :not_found
  end

  # GET /budgies.json
  def index
    cond = params.permit(:id, :name, :gender, :color_id, :age, :tribal).slice(:id, :name, :gender, :color_id, :age, :tribal)

    # @budgies = Budgie.all
    @budgies = Budgie.where cond
    respond_with @budgies
  end

  # GET /budgies/1.json
  def show
    respond_with @budgie
  end

  # POST /budgies.json
  def create
    @budgie = Budgie.new budgie_params
    @budgie.save
    respond_with @budgie
  end

  # PATCH/PUT /budgies/1.json
  def update
    @budgie.update budgie_params
    respond_with @budgie
  end

    # DELETE /budgies/1.json
  def destroy
    @budgie.destroy
    head :no_content
  end

  # GET /budgies/1/descendents.json
  def descendents
    @budgies = @budgie.descendents
    respond_with @budgies
  end

  # GET /budgies/1/ancestors.json
  def ancestors
    @budgies = @budgie.ancestors
    respond_with @budgies
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budgie
      @budgie = Budgie.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budgie_params
      params.require(:budgie).permit(:name, :gender, :color_id, :age, :tribal, :father_id, :mother_id)
    end
end
