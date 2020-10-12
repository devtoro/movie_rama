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
end
