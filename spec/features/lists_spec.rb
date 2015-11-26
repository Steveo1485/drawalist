require 'rails_helper'

describe "Lists", :type => :feature do
  before :each do
    @membership = FactoryGirl.create(:membership)
    log_in_user(@membership.user)
  end

  context 'for user' do
    it 'should be displayed on user dashboard' do
      expect(page).to have_content("#{@membership.user.first_name}'s List")
    end

    it 'should allow items to be added' do
      list_item = FactoryGirl.build(:list_item)
      fill_in 'list_item_name', with: list_item.name
      fill_in 'list_item_url', with: list_item.url
      click_button('Add Item')
      expect(page).to have_content(list_item.name)
    end
  end

  context 'for paired user' do
    it 'should display no pair message when not yet paired' do
      expect(page).to have_content('Not Paired Yet')
    end
  end
end