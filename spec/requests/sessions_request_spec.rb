require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  context 'Authentication' do
    it 'renders the login page with the error when credentials are wrong'
    it 'redirects to root path when credentials are correct'
    it 'sets the the user in session when credentials are correct'
  end

  context 'Logout' do
    it 'removes user from session'
    it 'redirects to the login page'
  end
end
