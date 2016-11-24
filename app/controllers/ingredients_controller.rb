class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = Ingredient.all
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
    @meal = @ingredient.meal
  end

  # POST /ingredients
  def create
    sync_nutrient
    respond_to do |format|
      format.html { redirect_to  new_meal_path(params: { meal: { ingredients_attributes: [ingredient_params.to_unsafe_hash] } }) }
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    sync_nutrient
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @ingredient.meal, notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to @ingredient.meal, notice: 'Dosed nutrient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      float_fields = %i(calories carbs proteins fat quantity).each_with_object([]) do |method, result|
        result << method
        result << "#{method}_integral"
        result << "#{method}_fractional"
      end

      params.require(:ingredient).permit(:name, *float_fields)
    end

    def sync_nutrient
      if (params[:ingredient].delete(:save_as_favorite))
        Nutrient.create(ingredient_params.select{ |k, _| Nutrient.attribute_names.include?(k) && k != 'id' })
      end
    end
end
