require "rails_helper"

RSpec.describe MembershipsController, :type => :controller do
  describe 'GET #new' do
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
      it 'should redirect to new_user_session_path' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when signed in' do
      before :each do
        @user = FactoryGirl.create(:user)
        @group = FactoryGirl.create(:group)
        sign_in @user
      end

      it 'should create membership with valid group token' do
        expect{post :create, membership: {group_token: @group.token}}.to change{Membership.count}.from(1).to(2)
        # First membership created for admin user on group creation
      end

      it 'should not create with invalid group token' do
        expect{post :create, membership: {group_token: 'wrongtoken'}}.to_not change{Membership.count}
      end

      it 'should not create if user is already a member of group' do
        FactoryGirl.create(:membership, user: @user, group: @group)
        expect{post :create, membership: {group_token: @group.token}}.to_not change{Membership.count}
      end
    end

    context 'when not signed in' do
      it 'should redirect to new_user_session_path' do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end