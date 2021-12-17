class MealsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.includes(:ingredients).for_week(params[:week]).order(consumption_time: :desc)
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    @meal = Meal.find(params[:id])
  end

  # GET /meals/new
  def new
    @form_object = Meal::FormObject.new(consumption_time: DateTime.now)
  end

  # GET /meals/1/edit
  def edit
    @form_object = Meal::FormObject.find(params[:id])
  end

  # POST /meals
  # POST /meals.json
  def create

    @form_object = Meal::FormObject.new(form_object_params)
    # TODO: I guess the right way should be to have different paths:
    # POST meals/new/ingredient => goes back to POST meal/new
    # POST meals/:meal_id/ingredient => goes back to POST meal/:meal_id/edit
    # and let this paths be handled by the meal_builder_controller, which does not need the authentication token

    puts "*** meals_controller#create #{@form_object.as_json}"
    if (@form_object.ingredient_index.nil?) then verify_authenticity_token end

    respond_to do |format|
      if (@form_object.ingredient_index.nil? && @form_object.save)
        format.html { redirect_to @form_object, notice: 'Meal was successfully created.', only_path: true }
        format.json { render :show, status: :created, location: @form_object }
      else
        # the new template renders both the new meal page. as well as what should be the meal_ingredient pages
        format.html { render :new }
        format.json { render json: @form_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    @form_object = Meal::FormObject.find(params[:id])
    @form_object.assign_attributes(form_object_params)
    respond_to do |format|
      if (@form_object.ingredient_index.nil? && @form_object.save)
        format.html { redirect_to @form_object, notice: 'Meal was successfully updated.', only_path: true }
        format.json { render :show, status: :ok, location: @form_object }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.', only_path: true }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_object_params
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
