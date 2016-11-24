class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.includes(:ingredients)
      .order(consumption_time: :desc)
      .paginate(page: params[:page], per_page: 10)
  end

  # GET /meals
  def show
    @meal.assign_attributes(session.fetch(:meal, {}).delete(params[:id]) || {})
  end

  # GET /meals/new
  def new
    params[:meal] ||= { consumption_time: DateTime.now }
    @meal = Meal.new(meal_params)
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to meal_path(@meal), notice: 'Meal was successfully created.' }
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
    respond_to do |format|
      if (params[:new_ingredient])
        @ingredient = Ingredient.create(meal: @meal)
        session[:meal] = { @meal.id => meal_params }
        format.html { redirect_to @ingredient }
      elsif (params[:edit_ingredient])
        session[:meal] = { @meal.id => meal_params }
        format.html { redirect_to @meal.ingredients[params[:edit_ingredient].keys.first.to_i]}
      elsif (params[:delete_ingredient])
        meal_index = params[:delete_ingredient].keys.first
        @meal.ingredients[meal_index.to_i].destroy
        #params[:meal][:ingredients_attributes][meal_index][:_destroy] = true
        params[:meal][:ingredients_attributes].delete(meal_index)
        session[:meal] = { @meal.id => meal_params }
        format.html { redirect_to @meal }
      elsif @meal.update(meal_params)
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
      format.html { redirect_to meals_path }
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
                                   ingredients_attributes: %i(id _destroy, name calories carbs proteins fat quantity) )
    end
end
