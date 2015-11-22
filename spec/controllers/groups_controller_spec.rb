require "rails_helper"

RSpec.describe GroupsController, :type => :controller do

  describe "GET #new" do
    context 'when signed in' do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it 'responds successfully with an HTTP 200 status code' do
        get :new
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'should render the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when not signed in' do
      it 'responds unsuccessfully with an HTTP 302 status code' do
        get :new
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST #create' do
    before :each do
      @user = FactoryGirl.create(:user)
      @group = FactoryGirl.build(:group, admin_user: @user)
    end

    context 'when signed in' do
      before :each do
        sign_in @user
      end

      it 'should create new group with valid attributes' do
        expect{post :create, group: @group.attributes }.to change{Group.count}.from(0).to(1)
      end

      it 'should not create group with invalid attributes' do
        expect{post :create, group: {name: ''} }.to_not change{Group.count}
      end

      it 'should create group for signed in user' do
        post :create, group: @group.attributes
        expect(Group.last.admin_user).to eq(@user)
      end
    end

    context 'when not signed in' do
      it 'responds unsuccessfully with an HTTP 302 status code' do
        post :create, group: @group.attributes
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET #show' do
    context 'when signed in' do
      before :each do
        @user = FactoryGirl.create(:user)
        @group = FactoryGirl.create(:group, admin_user: @user)
        sign_in @user
      end

      it 'responds successfully with an HTTP 200 status code' do
        get :show, id: @group.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'should render the new template' do
        get :show, id: @group.id
        expect(response).to render_template(:show)
      end
    end

    context 'when not signed in' do
      it 'responds unsuccessfully with an HTTP 302 status code' do
        get :show, id: FactoryGirl.create(:group).id
        expect(response).to have_http_status(302)
      end
    end
  end
end