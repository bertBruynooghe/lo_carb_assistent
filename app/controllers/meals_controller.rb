class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.includes(:ingredients)
      .order(consumption_time: :desc)
      .paginate(page: params[:page], per_page: 10)
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = Forms::Meal.new({})
  end

  # GET /meals/1/edit
  def edit
    @meal = Forms::Meal.new(@meal)
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Forms::Meal.new(meal_params)
    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    @meal = Forms::Meal.new(@meal)
    @meal.assign_attributes(meal_params)
    respond_to do |format|
      if @meal.save(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:consumption_time,
                                   :new_ingredient,
                                   ingredients_attributes: %i(id
                                                              name
                                                              calories_integral
                                                              carbs_integral
                                                              proteins_integral
                                                              fat_integral
                                                              quantity_integral
                                                              calories_fractional
                                                              carbs_fractional
                                                              proteins_fractional
                                                              fat_fractional
                                                              quantity_fractional
                                                              commit
                                                              save_as_nutrient
                                                              _destroy))
    end
end
