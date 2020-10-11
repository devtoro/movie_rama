require 'rails_helper'

RSpec.describe 'Users Registration', type: :request do
  context 'Registration' do
    it 'responds with 422 status on unsuccessfull user creation due to wrong params' do
      params = { user: { full_name: 'some name' } }
      post '/users', params: params

      expect(response).to have_http_status(422)
    end

    it 'responds with 302 status on successfull user creation' do
      params = {
        user: {
          full_name: 'some name',
          email: 'some@mail.com',
          password: '12345678'
        }
      }

      post '/users', params: params
      expect(response).to have_http_status(302)
    end
  end
end
