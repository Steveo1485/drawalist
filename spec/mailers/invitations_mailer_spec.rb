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
  end
end
