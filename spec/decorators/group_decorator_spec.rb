require 'rails_helper'

describe GroupDecorator do
  before :each do
    @group = FactoryGirl.create(:group)
  end

  context '#display_name' do
    it 'should include administrator designation when signed in user is the group admin' do
      sign_in @group.admin_user
      expect(@group.decorate.display_name).to eq("#{@group.name} #{h.content_tag(:span, '(Administrator)', class: 'group-admin-title')}")
    end

    it 'should only display group name if signed in user is not the group admin' do
      membership = FactoryGirl.create(:membership, group: @group)
      sign_in membership.user
      expect(@group.decorate.display_name).to eq(@group.name)
    end
  end

end
