require 'rails_helper'

RSpec.describe Group, :type => :model do

  it 'should create token after create' do
    group = FactoryGirl.build(:group)
    expect(group.token).to eq(nil)
    group.save
    expect(group.token).to_not eq(nil)
  end

end
