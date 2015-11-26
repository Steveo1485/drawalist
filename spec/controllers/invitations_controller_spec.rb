require "rails_helper"

RSpec.describe InvitationsController, :type => :controller do

  describe 'POST #create' do
    before :each do
      @group = FactoryGirl.create(:group)
      @invitation = FactoryGirl.build(:invitation, group: @group)
    end

    context 'when signed in' do
      before :each do
        sign_in @group.admin_user
      end

      it 'should create new invitation with valid attributes' do
        expect{post :create, invitation: @invitation.attributes }.to change{Invitation.count}.from(0).to(1)
      end

      it 'should not create invitation with invalid attributes' do
        expect{post :create, invitation: {group_id: @group.id} }.to_not change{Invitation.count}
      end
    end

    context 'when not signed in' do
      it 'responds unsuccessfully with an HTTP 302 status code' do
        post :create, invitation: @invitation.attributes
        expect(response).to have_http_status(302)
      end
    end
  end


end