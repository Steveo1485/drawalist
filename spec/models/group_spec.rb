require 'rails_helper'

RSpec.describe Group, :type => :model do

  it 'should create token after create' do
    group = FactoryGirl.build(:group)
    expect(group.token).to eq(nil)
    group.save
    expect(group.token).to_not eq(nil)
  end

  it 'should create a membership for the admin user after create' do
    group = FactoryGirl.build(:group)
    expect{group.save}.to change{Membership.count}.from(0).to(1)
    expect(Membership.last.user).to eq(group.admin_user)
  end
end
