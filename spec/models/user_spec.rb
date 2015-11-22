require 'rails_helper'

RSpec.describe User, :type => :model do

  before :all do
    @user = FactoryGirl.create(:user)
  end

  context 'groups' do
    before :all do
      @admin_group = FactoryGirl.create(:group, admin_user: @user)
      @new_membership = FactoryGirl.create(:membership, user: @user)
    end

    it 'should have association to return groups where user is the admin' do
      expect(@user.admin_groups).to eq([@admin_group])
    end

    it 'should have association to return groups where user is a member' do
      expect(@user.groups.pluck(:id).sort).to eq([@new_membership.group.id, @admin_group.id].sort)
    end
  end

  it '#name should return string of first_name and last_name' do
    expect(@user.name).to eq("#{@user.first_name} #{@user.last_name}")
  end

end
