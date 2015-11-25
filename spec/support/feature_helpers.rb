def log_in_user(user)
  visit root_path
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  click_button('Sign In')
end