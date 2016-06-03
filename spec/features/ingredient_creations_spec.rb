require 'rails_helper'

RSpec.feature "IngredientCreations", type: :feature do
  describe "the signin process", :type => :feature do
    before :each do
      User.create(:email => 'user@example.com', :password => 'password')
    end

    it "signs me in" do
      visit '/'
      within("#new_user") do
        fill_in 'Email', :with => 'user@example.com'
        fill_in 'Password', :with => 'password'
      end
      click_button I18n.t('.devise.sessions.new.sign_in')
      expect(page).to have_content I18n.t('.devise.sessions.signed_in')

      click_link_or_button I18n.t('meals.index.new')
      expect(page).to have_content 'Nieuw ingredient'
      meal_url = current_url
      click_link_or_button 'Nieuw ingredient'

      fill_in Ingredient.human_attribute_name(:quantity), with: '100'
      fill_in Ingredient.human_attribute_name(:name), with: 'some nutrient'
      fill_in Ingredient.human_attribute_name(:carbs), with: '7,5'
      fill_in Ingredient.human_attribute_name(:proteins), with: '3'
      fill_in Ingredient.human_attribute_name(:fat), with: '4'
      fill_in Ingredient.human_attribute_name(:calories), with: '7'
      click_link_or_button I18n.t(:add)
      expect(current_url).to eq(meal_url)
      expect(page).to have_content 'some nutrient'
    end
  end
end
