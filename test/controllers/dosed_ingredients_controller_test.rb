require 'test_helper'

class DosedIngredientsControllerTest < ActionController::TestCase
  setup do
    @dosed_ingredient = dosed_ingredients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dosed_ingredients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dosed_ingredient" do
    assert_difference('DosedIngredient.count') do
      post :create, dosed_ingredient: { calories: @dosed_ingredient.calories, carbs: @dosed_ingredient.carbs, fat: @dosed_ingredient.fat, name: @dosed_ingredient.name, proteins: @dosed_ingredient.proteins, quantity: @dosed_ingredient.quantity }
    end

    assert_redirected_to dosed_ingredient_path(assigns(:dosed_ingredient))
  end

  test "should show dosed_ingredient" do
    get :show, id: @dosed_ingredient
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dosed_ingredient
    assert_response :success
  end

  test "should update dosed_ingredient" do
    patch :update, id: @dosed_ingredient, dosed_ingredient: { calories: @dosed_ingredient.calories, carbs: @dosed_ingredient.carbs, fat: @dosed_ingredient.fat, name: @dosed_ingredient.name, proteins: @dosed_ingredient.proteins, quantity: @dosed_ingredient.quantity }
    assert_redirected_to dosed_ingredient_path(assigns(:dosed_ingredient))
  end

  test "should destroy dosed_ingredient" do
    assert_difference('DosedIngredient.count', -1) do
      delete :destroy, id: @dosed_ingredient
    end

    assert_redirected_to dosed_ingredients_path
  end
end
