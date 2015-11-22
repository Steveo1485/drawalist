require 'rails_helper'

RSpec.describe User, :type => :model do

  context 'groups' do
    before :all do
      @user = FactoryGirl.create(:user)
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

end
