require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  context "Create action - Login" do
    before do
      @user = FactoryBot.create(:user)
      @params = { session: { email: @user.email, password: "movierama" } }
    end

    it "Redirects to root path after successfull login" do
      post :create, params: @params
      is_expected.to set_session[:user_id]
      is_expected.to redirect_to(root_path)
    end

    it "Redirects to forwarding url (in session) if it exists" do
      post :create,
           params: @params,
           session: { forwarding_url: new_movie_path }
      is_expected.to redirect_to(new_movie_path)
    end

    it "Renders new if incorrect credentials" do
      post :create, params: { session: { email: "test", password: "test" } }

      is_expected.to render_template(:new)
      is_expected.to set_flash[:error]
    end
  end

  context "Logout" do
    it "Removes :user_id from session and redirect to root url" do
      delete :destroy,
             params: {},
             session: { user_id: 1 }

      session.should be_empty
      is_expected.to redirect_to(root_path)
    end
  end
end
