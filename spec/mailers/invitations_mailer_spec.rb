require "rails_helper"

RSpec.describe InvitationsMailer, :type => :mailer do

  before :each do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  describe "#invitation" do
    before :each do
      @email = Faker::Internet.email
      @group = FactoryGirl.create(:group)
      @mail = InvitationsMailer.invitation(@email, @group).deliver_now
    end

    it "should have the expected subject" do
      expect(@mail.subject).to eq("You've been invited to join #{@group.name}")
    end

    it 'should be sent to the intended address' do
      expect(@mail.to).to eq([@email])
    end

    it 'should include correct body' do
      expect(@mail.body).to have_content("#{@group.admin_user.first_name} has invited you to join #{@group.name} at DrawAList.com")
    end
  end
end