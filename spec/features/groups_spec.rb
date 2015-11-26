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
      set_up_mailer
      expect(ActionMailer::Base.deliveries.count).to eq(0)
      email = Faker::Internet.email
      email_two = Faker::Internet.email
      fill_in('group_name', with: @group.name)
      fill_in('group_invitation_emails', with: "#{email}\r\n#{email_two}")
      click_button('Create Group')
      expect(Invitation.first.email).to eq(email)
      expect(Invitation.last.email).to eq(email_two)
      expect(ActionMailer::Base.deliveries.count).to eq(2)
      expect(ActionMailer::Base.deliveries.first.to).to eq([email])
    end
  end

  context 'details' do
    before :each do
      @admin = FactoryGirl.create(:user)
      @group = FactoryGirl.create(:group, admin_user: @admin)
      @memberships = create_list(:membership, 3, group: @group)
    end

    context 'as group admin' do
      before :each do
        log_in_user(@admin)
        click_link('Group Details')
      end

      it 'should allow admin to view token to share' do
        expect(page).to have_content(@group.token)
      end

      it 'should show full member names' do
        expect(page).to have_content(@memberships.last.user.first_name)
        expect(page).to have_content(@memberships.last.user.last_name)
      end

      it 'should allow sending new invitations' do
        set_up_mailer
        expect(ActionMailer::Base.deliveries.count).to eq(0)
        email = Faker::Internet.email
        fill_in('invitation_email', with: email)
        click_button('Send Invitation')
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries.last.to).to eq([email])
      end

      it 'should show error if new invitation cannot be sent' do
        email = Faker::Internet.email
        FactoryGirl.create(:invitation, group: @group, email: email)
        set_up_mailer
        expect(ActionMailer::Base.deliveries.count).to eq(0)
        fill_in('invitation_email', with: email)
        click_button('Send Invitation')
        expect(ActionMailer::Base.deliveries.count).to eq(0)
        expect(page).to have_content('Something went wrong, please try again.')
      end
    end

    context 'as group member' do
      before :each do
        log_in_user(@memberships.first.user)
        click_link('Group Details')
      end

      it 'should not display token to share' do
        expect(page).to_not have_content(@group.token)
      end

      it 'should only show member first names' do
        expect(page).to have_content(@memberships.last.user.first_name)
        expect(page).to_not have_content(@memberships.last.user.last_name)
      end

      it 'should now display invitation form' do
        expect(page).to_not have_content('Send new invitations')
      end
    end
  end
end