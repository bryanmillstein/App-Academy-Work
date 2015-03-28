require 'spec_helper'
require 'rails_helper'

feature "Goals" do
  before(:each) do
    sign_up_user('Bobby', 'password')
    visit new_goal_url
    fill_in('Title', with: 'Lose Five Pounds')
    fill_in('Notes', with: 'Cuz ur a lil chubz')
    choose('Public')
    click_button("Let's do it")
  end

  feature "Creating a goal" do

    scenario "cant create goal unless signed in" do
      click_button("Log Out")
      visit new_goal_url
      expect(page).to have_content "Bonjour Le Log In Page"
    end

    scenario "goal is added to user's show page" do
      expect(page).to have_content("~~Mah Profile~~")
      expect(page).to have_content('Lose Five Pounds')
    end
  end

  feature "Goal has show_page" do

    scenario "goal has show page" do
      click_link("Lose Five Pounds")
      expect(page).to have_content("Cuz ur a lil chubz")
    end
  end

  feature "displaying goals on user#show page" do

    scenario "only display current user's private goals" do
      goal = Goal.last
      goal.privacy = 'Private'
      goal.save
      click_button('Log Out')

      sign_up_user('Jill', 'password')
      visit user_url(goal.user)
      save_and_open_page

      expect(page).to_not have_content('Lose Five Pounds')
    end

    scenario "have a link to new goal" do
      click_button("Get Rockin'")
      expect(page).to have_content('Get your goal on!')
    end
  end


  feature "displaying goals on goal#index page" do
    before(:each) { visit goals_url }

    scenario "button to return to current user's show page" do
      click_button("Mah Profile")
      expect(page).to have_content("~~Mah Profile~~")
    end

    scenario "must be signed in to view goals" do
      click_button("Log Out")
      visit goals_url
      expect(page).to have_content "Bonjour Le Log In Page"
    end

    scenario "display goal owner (Bobby)" do
      expect(page).to have_content('Bobby')
    end

    scenario "Username links to goal owner's show page" do
      click_link('Bobby')
      expect(page).to have_content('Bobby')
    end
  end

  feature "editing a goal" do

    scenario "can't edit unless signed in" do
      click_button('Log Out')
      visit edit_goal_url(Goal.first)
      expect(page).to have_content "Bonjour Le Log In Page"
    end

    scenario "form autocompletes existing attributes" do
      visit edit_goal_url(Goal.last)
      expect(page).to have_content('Cuz ur a lil chubz')
    end

    scenario "can't edit other peoples goals" do
      click_button('Log Out')

      sign_up_user('Jill', 'password')
      visit edit_goal_url(Goal.last)
      expect(page).to have_content("Bobby")
    end

  end

  feature "destroying a goal" do

    scenario "delete button only appears for goal owner" do
      click_button('Log Out')
      sign_up_user('Jill', 'password')
      visit user_url(User.find_by_credentials('Bobby', "password"))
      expect(page).to_not have_content('Delete')
    end

    scenario "redirects to user show page on completion" do
      click_button("Delete")
      expect(page).to have_content('~~Mah Profile~~')
    end

    scenario "remove from display upon deletion" do
      click_button("Delete")
      expect(page).to_not have_content('Lose Five Pounds')
    end

  end
end
