require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Acceptance test for user update', type: :feature do
  it 'Does not allow a user to update another user data', js: true do
    2.times { |i| FactoryBot.create(:user) }

    visit '/login'
    within('#login-form') do
      fill_in 'Email', with: User.first.email
      fill_in 'Password', with: 'movierama'
    end

    click_button 'Login'

    visit "/users/#{User.last.id}/edit"
    click_button 'Save'

    expect(page).to have_content 'Cannot edit another user data'
  end
end
