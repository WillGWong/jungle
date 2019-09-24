require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    User.create!(
      name: "Bob",
      email: "john@doe.com",
      password: "some_password"
    )
  end

  scenario "Logging in with valid email and password logs a user in" do
    visit root_path
    click_on('Login')
    fill_in 'email', with: "john@doe.com"
    fill_in 'password', with: "some_password"
    click_on('Submit')
    expect(page).to have_text 'Signed in as Bob'
    save_screenshot
  end
end
