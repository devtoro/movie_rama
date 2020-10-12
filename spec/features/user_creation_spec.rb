require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User creation procedure', type: :feature do
  it 'Redirects to login when successfully created' do
    visit '/signup'
    within('#user-form') do
      fill_in 'Full Name', with: 'full name'
      fill_in 'Email', with: 'some@email.com'
      fill_in 'Password', with: 'movierama'
    end

    click_button 'Save'

    expect(page).to have_content 'Login'
  end

  it 'Shows validation error', js: true do
    # First we have to login
    visit '/signup'
    within('#user-form') do
      fill_in 'Email', with: 'some@email.com'
      fill_in 'Password', with: 'movierama'
    end

    click_button 'Save'

    # New movie title should be present inside the list of the movies
    expect(page).to have_content 'can\'t be blank'
  end

  it 'Shows validation error if email not unique', js: true do
    user = FactoryBot.create(:user)
    # First we have to login
    visit '/signup'
    within('#user-form') do
      fill_in 'Full Name', with: 'full name'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'movierama'
    end

    click_button 'Save'

    # New movie title should be present inside the list of the movies
    expect(page).to have_content 'has already been taken'
  end
end
