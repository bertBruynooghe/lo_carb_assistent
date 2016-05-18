require 'rails_helper'

RSpec.describe "blood_sugar_readings/new", type: :view do
  before(:each) do
    assign(:blood_sugar_reading, BloodSugarReading.new(
      :value => 1
    ))
  end

  it "renders new blood_sugar_reading form" do
    render

    assert_select "form[action=?][method=?]", blood_sugar_readings_path, "post" do

      assert_select "input#blood_sugar_reading_value[name=?]", "blood_sugar_reading[value]"
    end
  end
end
