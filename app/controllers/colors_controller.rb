class ColorsController < ApplicationController
  respond_to :json
  before_action :set_color, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {error: exception.message}, status: :not_found
  end

  # GET /colors.json
  def index
    @colors = Color.all
    respond_with @colors
  end

  # GET /colors/1.json
  def show
    respond_with @color
  end

  # POST /colors.json
  def create
    @color = Color.new color_params
    @color.save
    respond_with @color
  end

  # PATCH/PUT /colors/1.json
  def update
    @color.update color_params
    respond_with @color
  end

  # DELETE /colors/1.json
  def destroy
    @color.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_params
      params.require(:color).permit(:name)
    end
end
