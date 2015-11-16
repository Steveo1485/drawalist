require 'rails_helper'

describe "The sign in process", :type => :feature do

  before :each do
    @user = FactoryGirl.create(:user)
  end

  it "should redirect to user dashboard after successful sign in" do
    visit root_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    expect(current_path).to eq(dashboard_path)
  end

  it 'should display error messages on unsuccessful sign in' do
    visit root_path
    fill_in 'user_email', with: 'bad@email.com'
    fill_in 'user_password', with: 'wrongpassword'
    click_button('Sign In')
    expect(page).to have_content('Invalid email or password')
  end
end