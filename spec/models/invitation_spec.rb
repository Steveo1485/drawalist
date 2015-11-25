require 'rails_helper'

RSpec.describe Invitation, :type => :model do

  context 'invitation email' do
    it 'should send after create' do
      set_up_mailer
      expect(ActionMailer::Base.deliveries.count).to eq(0)
      invitation = FactoryGirl.build(:invitation)
      invitation.save
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

end
