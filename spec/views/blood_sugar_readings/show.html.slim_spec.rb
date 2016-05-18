require 'rails_helper'

RSpec.describe "blood_sugar_readings/show", type: :view do
  before(:each) do
    @blood_sugar_reading = assign(:blood_sugar_reading, BloodSugarReading.create!(
      :value => 1, read_time: DateTime.now
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
