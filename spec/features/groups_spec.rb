require 'rails_helper'

describe "Group", :type => :feature do

  context 'creation process' do
    before :each do
      @user = FactoryGirl.create(:user)
      @group = FactoryGirl.build(:group)
      log_in_user(@user)
      click_link('Create a Group')
    end

    it "should display group details after successful creation" do
      fill_in('group_name', with: @group.name)
      click_button('Create Group')
      expect(current_path).to eq(group_path(Group.last))
      expect(page).to have_content(@group.name)
    end

    it 'should display error messages on unsuccessful creation' do
      click_button('Create Group')
      expect(page).to have_content("Name can't be blank")
    end

    it 'should allow user to send invitations' do
      email = Faker::Internet.email
      email_two = Faker::Internet.email
      fill_in('group_name', with: @group.name)
      fill_in('group_invitation_emails', with: "#{email}\r\n#{email_two}")
      click_button('Create Group')
      expect(Invitation.first.email).to eq(email)
      expect(Invitation.last.email).to eq(email_two)
      expect(page).to have_content(email)
      expect(page).to have_content(email_two)
    end
  end
end