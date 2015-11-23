require 'rails_helper'

describe "Memberships", :type => :feature do

  before :each do
    @group = FactoryGirl.create(:group)
  end

  context 'as existing user' do
    before :each do
      @user = FactoryGirl.create(:user)
      log_in_user(@user)
      click_link('Join a Group')
    end

    it "should allow creation of membership with known group token" do
      fill_in('membership[group_token]', with: @group.token)
      click_button('Join Group')
      expect(current_path).to eq(user_root_path)
      expect(page).to have_content(@group.name)
    end

    it 'should display error messages on unsuccessful creation of membership' do
      fill_in('membership[group_token]', with: 'wrongtoken')
      click_button('Join Group')
      expect(page).to have_content("Invalid group token. Please try again.")
    end
  end
end