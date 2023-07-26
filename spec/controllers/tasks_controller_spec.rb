require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "GET #index" do
    it "renders the index template and returns HTTP status 200" do
      user = create(:user)
      sign_in user
      
      get :index

      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end
end
