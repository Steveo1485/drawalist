require "rails_helper"

RSpec.describe ListItemsController, :type => :controller do


  describe 'POST #create' do
    before :each do
      @list = FactoryGirl.create(:list)
      @list_item = FactoryGirl.build(:list_item, list: @list)
    end

    context 'when signed in' do
      before :each do
        sign_in @list.user
      end

      it 'should create new list item with valid attributes' do
        expect{post :create, list_item: @list_item.attributes }.to change{ListItem.count}.from(0).to(1)
      end

      it 'should not create list item with invalid attributes' do
        expect{post :create, list_item: {list_id: @list.id, name: ''} }.to_not change{ListItem.count}
      end
    end

    context 'when not signed in' do
      it 'responds unsuccessfully with an HTTP 302 status code' do
        post :create, list_item: @list_item.attributes
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when signed in' do
      before :each do
        @user = FactoryGirl.create(:user)
        @list = FactoryGirl.create(:list, user: @user)
        @list_item = FactoryGirl.create(:list_item, list: @list)
      end

      it 'should not destroy list item if it does not belong to signed in user' do
        sign_in FactoryGirl.create(:user)
        expect{delete :destroy, id: @list_item.id }.to_not change{ListItem.count}
      end

      it 'should destroy list item if it belongs to signed in user' do
        sign_in @user
        expect{delete :destroy, id: @list_item.id }.to change{ListItem.count}.from(1).to(0)
      end
    end

    context 'when not signed in' do
      it 'responds unsuccessfully with an HTTP 302 status code' do
        delete :destroy, id: FactoryGirl.create(:list_item)
        expect(response).to have_http_status(302)
      end
    end

  end

end