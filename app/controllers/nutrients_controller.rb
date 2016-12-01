class NutrientsController < ApplicationController
  before_action :set_nutrient, only: [:show, :edit, :update, :destroy]

  # GET /nutrients
  # GET /nutrients.json
  def index
    @nutrients = Nutrient.search(params[:q]).result.order(name: :asc)
  end

  # GET /nutrients/1
  # GET /nutrients/1.json
  def show
  end

  # GET /nutrients/new
  def new
    @nutrient = Nutrient.new
  end

  # GET /nutrients/1/edit
  def edit
  end

  # POST /nutrients
  # POST /nutrients.json
  def create
    @nutrient = Nutrient.new(nutrient_params)

    respond_to do |format|
      if @nutrient.save
        format.html { redirect_to nutrients_path, notice: 'Nutrient was successfully created.' }
        format.json { render :show, status: :created, location: @nutrient }
      else
        format.html { render :new }
        format.json { render json: @nutrient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nutrients/1
  # PATCH/PUT /nutrients/1.json
  def update
    respond_to do |format|
      if @nutrient.update(nutrient_params)
        format.html { redirect_to @nutrient, notice: 'Nutrient was successfully updated.' }
        format.json { render :show, status: :ok, location: @nutrient }
      else
        format.html { render :edit }
        format.json { render json: @nutrient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nutrients/1
  # DELETE /nutrients/1.json
  def destroy
    @nutrient.destroy
    respond_to do |format|
      format.html { redirect_to nutrients_url, notice: 'Nutrient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nutrient
      @nutrient = Nutrient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nutrient_params
      float_fields = %i(calories carbs proteins fat)
      float_fields = float_fields.map{|i| :"#{i}_fractional"} + float_fields.map{|i| :"#{i}_integral"}
      params.require(:nutrient).permit(:name, *float_fields)
    end
end
