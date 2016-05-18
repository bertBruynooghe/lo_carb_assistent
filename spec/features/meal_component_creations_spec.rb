require 'rails_helper'

RSpec.feature "MealComponentCreations", type: :feature do
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
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'

      click_link_or_button 'New Meal'
      expect(page).to have_content 'New Dosed nutrient'
      meal_url = current_url
      click_link_or_button 'New Dosed nutrient'

      fill_in 'Quantity', with: '100'
      fill_in 'Name', with: 'some nutrient'
      fill_in 'Carbs', with: '7,5'
      fill_in 'Proteins', with: '3'
      fill_in 'Fat', with: '4'
      fill_in 'Calories', with: '7'
      click_link_or_button 'Save'
      expect(current_url).to eq(meal_url)
      expect(page).to have_content 'some nutrient'
    end
  end
end
