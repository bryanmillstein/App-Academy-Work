require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Bonjour Le Sign Up Page"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      sign_up_user("raddude33", "kiracohen1")
      expect(page).to have_content('raddude33')
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    user = FactoryGirl.create(:user)
    log_in_user(user.username, 'kiracohen1')
    expect(page).to have_content(user.username)
  end

end

feature "logging out" do
  let(:user) {FactoryGirl.create(:user)}

  scenario "begins with logged out state" do
    visit new_session_url
    expect(page).to_not have_content(user.username)
  end

  scenario "doesn't show username on the homepage after logout" do
    log_in_user(user.username, 'kiracohen1')
    click_button('Log Out')
    expect(page).to_not have_content(user.username)
  end

end
