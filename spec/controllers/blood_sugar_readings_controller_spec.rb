require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe BloodSugarReadingsController, type: :controller do
  before { allow(controller).to receive(:authenticate_user!) }

  # This should return the minimal set of attributes required to create a valid
  # BloodSugarReading. As you add validations to BloodSugarReading, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { value: 344, read_time: DateTime.now } }

  let(:invalid_attributes) { { value: nil, read_time: DateTime.now } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BloodSugarReadingsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all blood_sugar_readings as @blood_sugar_readings" do
      blood_sugar_reading = BloodSugarReading.create! valid_attributes
      get :index, params: {}
      expect(assigns(:blood_sugar_readings)).to eq([blood_sugar_reading])
    end
  end

  describe "GET #show" do
    it "assigns the requested blood_sugar_reading as @blood_sugar_reading" do
      blood_sugar_reading = BloodSugarReading.create! valid_attributes
      get :show, params: {:id => blood_sugar_reading.to_param}
      expect(assigns(:blood_sugar_reading)).to eq(blood_sugar_reading)
    end
  end

  describe "GET #new" do
    it "assigns a new blood_sugar_reading as @blood_sugar_reading" do
      get :new, params: { blood_sugar_reading: { read_time: DateTime.now } }
      expect(assigns(:blood_sugar_reading)).to be_a_new(BloodSugarReading)
    end
  end

  describe "GET #edit" do
    it "assigns the requested blood_sugar_reading as @blood_sugar_reading" do
      blood_sugar_reading = BloodSugarReading.create! valid_attributes
      get :edit, params: {:id => blood_sugar_reading.to_param}
      expect(assigns(:blood_sugar_reading)).to eq(blood_sugar_reading)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new BloodSugarReading" do
        expect {
          post :create, params: {:blood_sugar_reading => valid_attributes}
        }.to change(BloodSugarReading, :count).by(1)
      end

      it "assigns a newly created blood_sugar_reading as @blood_sugar_reading" do
        post :create, params: {:blood_sugar_reading => valid_attributes}
        expect(assigns(:blood_sugar_reading)).to be_a(BloodSugarReading)
        expect(assigns(:blood_sugar_reading)).to be_persisted
      end

      it "redirects to the created blood_sugar_reading" do
        post :create, params: {:blood_sugar_reading => valid_attributes}
        expect(response).to redirect_to(BloodSugarReading.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved blood_sugar_reading as @blood_sugar_reading" do
        post :create, params: {blood_sugar_reading: invalid_attributes}
        expect(assigns(:blood_sugar_reading)).to be_a_new(BloodSugarReading)
      end

      it "re-renders the 'new' template" do
        post :create, params: {blood_sugar_reading: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { value: 134 } }

      it "updates the requested blood_sugar_reading" do
        blood_sugar_reading = BloodSugarReading.create! valid_attributes
        put :update, params: {id: blood_sugar_reading.to_param, :blood_sugar_reading => new_attributes}
        blood_sugar_reading.reload
        expect(blood_sugar_reading.value).to eq(134)
      end

      it "assigns the requested blood_sugar_reading as @blood_sugar_reading" do
        blood_sugar_reading = BloodSugarReading.create! valid_attributes
        put :update, params: {id: blood_sugar_reading.to_param, :blood_sugar_reading => valid_attributes}
        expect(assigns(:blood_sugar_reading)).to eq(blood_sugar_reading)
      end

      it "redirects to the blood_sugar_reading" do
        blood_sugar_reading = BloodSugarReading.create! valid_attributes
        put :update, params: {id: blood_sugar_reading.to_param, :blood_sugar_reading => valid_attributes}
        expect(response).to redirect_to(blood_sugar_reading)
      end
    end

    context "with invalid params" do
      it "assigns the blood_sugar_reading as @blood_sugar_reading" do
        blood_sugar_reading = BloodSugarReading.create! valid_attributes
        put :update, params: {id: blood_sugar_reading.to_param, :blood_sugar_reading => invalid_attributes}
        expect(assigns(:blood_sugar_reading)).to eq(blood_sugar_reading)
      end

      it "re-renders the 'edit' template" do
        blood_sugar_reading = BloodSugarReading.create! valid_attributes
        put :update, params: {id: blood_sugar_reading.to_param, :blood_sugar_reading => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested blood_sugar_reading" do
      blood_sugar_reading = BloodSugarReading.create! valid_attributes
      expect {
        delete :destroy, params: {id: blood_sugar_reading.to_param}
      }.to change(BloodSugarReading, :count).by(-1)
    end

    it "redirects to the blood_sugar_readings list" do
      blood_sugar_reading = BloodSugarReading.create! valid_attributes
      delete :destroy, params: {id: blood_sugar_reading.to_param}
      expect(response).to redirect_to(blood_sugar_readings_url)
    end
  end

end
