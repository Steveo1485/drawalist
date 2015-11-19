require 'rails_helper'

describe "The sign up process", :type => :feature do

  before :each do
    @user = FactoryGirl.build(:user)
  end

  it "should redirect to user dashboard after successful registration" do
    visit root_path
    click_link('Sign Up')
    fill_in 'user_first_name', with: @user.first_name
    fill_in 'user_last_name', with: @user.last_name
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    fill_in 'user_password_confirmation', with: @user.password
    click_button('Sign Up')
    expect(current_path).to eq(user_root_path)
  end

  it 'should display error messages on unsuccessful registration' do
    visit root_path
    click_link('Sign Up')
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button('Sign Up')
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end
end