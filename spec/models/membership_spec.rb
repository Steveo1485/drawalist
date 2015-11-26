require 'rails_helper'

RSpec.describe Membership, :type => :model do

  context 'after create' do
    before :all do
      @membership = FactoryGirl.build(:membership)
    end

    it 'should create list object for membership user and group' do
      @membership.save
      expect(List.last.user).to eq(@membership.user)
      expect(List.last.group).to eq(@membership.group)
    end
  end

end
