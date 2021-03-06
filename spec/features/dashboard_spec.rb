require 'rails_helper'

describe "User dashboard", :type => :feature do

  before :all do
    @user = FactoryGirl.create(:user)
  end

  context 'when user has no groups' do
    it "should display give no group message" do
      log_in_user(@user)
      expect(page).to have_content("Doesn't look like you're part of any groups just yet.")
    end
  end

  context 'when user has admin group' do
    before :each do
      @group = FactoryGirl.create(:group, admin_user: @user)
      log_in_user(@user)
    end

    it 'should display tag noting user is an admin of group' do
      expect(page).to have_content("#{@group.name} (Administrator)")
    end

    it 'should display link for group details' do
      expect(page).to have_content("Group Details")
    end
  end

  context 'when user has group memberships' do
    before :each do
      @group = FactoryGirl.create(:membership, user: @user).group
      log_in_user(@user)
    end

    it 'should display group name with no admin designation' do
      expect(page).to have_content(@group.name)
      expect(page).to_not have_content('Administrator')
    end
  end
end