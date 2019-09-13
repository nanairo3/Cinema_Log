module LoginSupport
  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button 'Login'
  end

  RSpec.configure do |config|
    config.include LoginSupport
  end
end