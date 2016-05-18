require "rails_helper"

RSpec.describe BloodSugarReadingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/blood_sugar_readings").to route_to("blood_sugar_readings#index")
    end

    it "routes to #new" do
      expect(:get => "/blood_sugar_readings/new").to route_to("blood_sugar_readings#new")
    end

    it "routes to #show" do
      expect(:get => "/blood_sugar_readings/1").to route_to("blood_sugar_readings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/blood_sugar_readings/1/edit").to route_to("blood_sugar_readings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/blood_sugar_readings").to route_to("blood_sugar_readings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/blood_sugar_readings/1").to route_to("blood_sugar_readings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/blood_sugar_readings/1").to route_to("blood_sugar_readings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/blood_sugar_readings/1").to route_to("blood_sugar_readings#destroy", :id => "1")
    end

  end
end
