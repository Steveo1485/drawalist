require "rails_helper"

RSpec.describe UsersController, :type => :controller do

  describe "GET #show" do

    context 'when signed in' do
      before :each do
        @user = FactoryGirl.create(:user)
      end

      it 'responds successfully with an HTTP 200 status code' do
        sign_in @user
        get :show
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'should render the home template' do
        sign_in @user
        get :show
        expect(response).to render_template(:show)
      end
    end

    context 'when not signed in' do
      it 'responds unsuccessfully with an HTTP 302 status code' do
        get :show
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "GET #new" do
    before :each do
      @group = FactoryGirl.create(:group)
    end

    it 'should redirect to root_path if no group token param' do
      get :new
      expect(response).to redirect_to(root_path)
    end

    it 'should redirect to membership#new if user is signed in' do
      sign_in FactoryGirl.create(:user)
      get :new, token: @group.token
      expect(response).to redirect_to(new_membership_path(token: @group.token))
    end

    it 'should render new template if not signed in and group token param present' do
      get :new, token: @group.token
      expect(response).to render_template(:new)
    end
  end
end