require 'rails_helper'

RSpec.feature 'InsulinDoseCreations', type: :feature do
  before :each do
    User.create(:email => 'user@example.com', :password => 'password')
  end

  it 'creates an insulin dose' do
    visit '/insulin_doses'
    within("#new_user") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button I18n.t('.devise.sessions.new.sign_in')
    click_on 'New Insulin dose'
  end
end
