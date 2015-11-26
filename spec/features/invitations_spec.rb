require 'rails_helper'

describe "Invitations", :type => :feature do
  before :each do
    @group = FactoryGirl.create(:group)
    @invitation = FactoryGirl.create(:invitation, group: @group)
  end

  context 'for an existing user' do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it 'should allow user to become member of group if already signed in' do
      log_in_user(@user)
      visit(new_user_path(token: @group.token))
      expect(current_path).to eq(new_membership_path)
      click_button('Join Group')
      expect(current_path).to eq(user_root_path)
      expect(page).to have_content(@group.name)
    end
  end

  context 'for a new user' do
    before :each do
      @user = FactoryGirl.build(:user)
    end

    it 'should allow user to sign up and become member of group' do
      visit(new_user_path(token: @group.token))
      fill_in 'user_first_name', with: @user.first_name
      fill_in 'user_last_name', with: @user.last_name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password
      click_button('Sign Up')
      expect(current_path).to eq(new_membership_path)
      click_button('Join Group')
      expect(current_path).to eq(user_root_path)
      expect(page).to have_content(@group.name)
    end
  end

end