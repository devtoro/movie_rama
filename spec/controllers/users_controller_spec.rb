RSpec.describe UsersController, type: :controller do
  before(:each) { post :create, params: params }

  context 'Create new user - Sign up - success' do
    let(:params) {
      {
        user: {
          full_name: 'some name',
          email: 'some@mail.com',
          password: '12345678'
        }
      }
    }


    it 'Adds success message to flash[:success] if user created successfully' do
      is_expected.to set_flash[:success]
    end

    it 'Redirects to login page if user created successfully' do
      is_expected.to redirect_to(login_path)
    end
  end

  context 'Create new user - Sign up - failed' do
    let(:params) {
      {
        user: { email: 'some@mail.com', password: '12678' }
      }
    }
    it 'Renders users#new and adds flash[:error] in case of error' do
      is_expected.to set_flash[:error]
    end

    it 'Adds all user errors to flash[:error] in case of user validation error' do
      # based on the params passed, we should have a password and full name error
      errors = flash[:error]

      expect(errors).not_to be_empty
      expect(errors[:full_name]).not_to be_empty
      expect(errors[:password]).not_to be_empty
      expect(errors[:password]).to eq(['is too short (minimum is 8 characters)'])
    end
  end
end
