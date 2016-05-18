class MealComponentsController < ApplicationController
  before_action :set_meal_component, only: [:show, :edit, :update, :destroy]

  # GET /meal_components
  # GET /meal_components.json
  def index
    @meal_components = MealComponent.all
  end

  # GET /meal_components/1
  # GET /meal_components/1.json
  def show
  end

  # GET /meal_components/new
  def new
    @meal = Meal.find(params[:meal_id])
    @meal_component = MealComponent.new
  end

  # GET /meal_components/1/edit
  def edit
    @meal = @meal_component.meal
  end

  # POST /meal_components
  # POST /meal_components.json
  def create
    @meal_component = MealComponent.new(meal_component_params.merge(meal_id: params[:meal_id]))

    respond_to do |format|
      if @meal_component.save
        format.html { redirect_to @meal_component.meal, notice: 'Dosed nutrient was successfully created.' }
        format.json { render :show, status: :created, location: @meal_component }
      else
        format.html { render :new }
        format.json { render json: @meal_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meal_components/1
  # PATCH/PUT /meal_components/1.json
  def update
    respond_to do |format|
      if @meal_component.update(meal_component_params)
        format.html { redirect_to @meal_component.meal, notice: 'Dosed nutrient was successfully updated.' }
        format.json { render :show, status: :ok, location: @meal_component }
      else
        format.html { render :edit }
        format.json { render json: @meal_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meal_components/1
  # DELETE /meal_components/1.json
  def destroy
    @meal_component.destroy
    respond_to do |format|
      format.html { redirect_to @meal_component.meal, notice: 'Dosed nutrient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal_component
      @meal_component = MealComponent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_component_params
      params.require(:meal_component).permit(:quantity, :name, :calories, :carbs, :proteins, :fat, :save)
    end
end
