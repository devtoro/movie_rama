require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Movie creation procedure', type: :feature do
  it 'Redirects to login if not authenticated' do
    visit '/movies/new'
    within('#movie-form') do
      fill_in 'Title', with: 'some title'
      fill_in 'Description', with: 'some description'
    end

    click_button 'Save'

    expect(page).to have_content 'Please log in first'
  end

  it 'Successfully creates movie when logged in' do
    user = FactoryBot.create(:user)
    # First we have to login
    visit '/login'
    within('#login-form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'movierama'
    end

    click_button 'Login'

    # Then click on the new movie button
    click_on('+ Movie')

    # Fill in the form to create the movie and click save
    within('#movie-form') do
      fill_in 'Title', with: 'some title'
      fill_in 'Description', with: 'some description'
    end

    click_button 'Save'

    # New movie title should be present inside the list of the movies
    expect(page).to have_content 'some title'
  end

  it 'Shows validation error', js: true do
    user = FactoryBot.create(:user)
    # First we have to login
    visit '/login'
    within('#login-form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'movierama'
    end

    click_button 'Login'

    # Then click on the new movie button
    click_on('+ Movie')

    # Fill in the form to create the movie and click save
    within('#movie-form') do
      fill_in 'Description', with: 'some description'
    end

    click_button 'Save'

    # New movie title should be present inside the list of the movies
    expect(page).to have_content 'can\'t be blank'
  end
end
