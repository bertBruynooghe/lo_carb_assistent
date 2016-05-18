require 'rails_helper'

RSpec.describe "blood_sugar_readings/edit", type: :view do
  before(:each) do
    @blood_sugar_reading = assign(:blood_sugar_reading, BloodSugarReading.create!(
      value: 1, read_time: DateTime.new
    ))
  end

  it "renders the edit blood_sugar_reading form" do
    render

    assert_select "form[action=?][method=?]", blood_sugar_reading_path(@blood_sugar_reading), "post" do

      assert_select "input#blood_sugar_reading_value[name=?]", "blood_sugar_reading[value]"
    end
  end
end
