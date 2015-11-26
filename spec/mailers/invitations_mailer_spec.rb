require "rails_helper"

RSpec.describe InvitationsMailer, :type => :mailer do

  before :each do
    set_up_mailer
  end

  describe "#invitation" do
    before :each do
      @invitation = FactoryGirl.create(:invitation)
      @mail = InvitationsMailer.invitation(@invitation).deliver_now
    end

    it "should have the expected subject" do
      expect(@mail.subject).to eq("You've been invited to join #{@invitation.group.name}")
    end

    it 'should be sent to the intended address' do
      expect(@mail.to).to eq([@invitation.email])
    end

    it 'should include correct body' do
      expect(@mail.body).to have_content("#{@invitation.group.admin_user.first_name} has invited you to join #{@invitation.group.name} at DrawAList.com")
    end
  end
end