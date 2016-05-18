require 'rails_helper'

RSpec.describe "blood_sugar_readings/index", type: :view do
  before(:each) do
    assign(:blood_sugar_readings, [
      BloodSugarReading.create!(
        :value => 1, read_time: DateTime.new
      ),
      BloodSugarReading.create!(
        :value => 1, read_time: DateTime.new
      )
    ])
  end

  it "renders a list of blood_sugar_readings" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
