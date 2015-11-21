require "rails_helper"

RSpec.describe PagesController, :type => :controller do
  describe "GET #home" do
    it 'responds successfully with an HTTP 200 status code' do
      get :home
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'should render the home template' do
      get :home
      expect(response).to render_template(:home)
    end

    it 'should redirect to user_root if user signed in' do
      sign_in FactoryGirl.create(:user)
      get :home
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_root_path)
    end
  end
end