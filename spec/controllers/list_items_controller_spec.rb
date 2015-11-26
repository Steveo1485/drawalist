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

end