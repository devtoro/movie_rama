RSpec.describe "layouts/_header.html.haml" do
  context "Profile section logged out" do
    it "Shows signup link if user not authenticated" do
      view.stub(:current_user) { nil }

      render

      expect(rendered).to have_link "Sign Up", href: "/signup"
    end

    it "Shows login link if user not authenticated" do
      view.stub(:current_user) { nil }

      render

      expect(rendered).to have_link "Login", href: "/login"
    end
  end

  context "Profile section logged in" do
    it "Shows new movie button if user is authenticated" do
      current_user = FactoryBot.create(:user)

      view.stub(:current_user) { current_user }

      render

      expect(rendered).to have_link "+ Movie", href: "/movies/new"
    end

    it "Shows new welcome message if user is authenticated" do
      current_user = FactoryBot.create(:user)
      view.stub(:current_user) { current_user }

      render

      expect(
        rendered
      ).to have_text("Welcome #{current_user.full_name.split(" ").first}")
    end

    it "Has a logout button if user is authenticated" do
      current_user = FactoryBot.create(:user)
      view.stub(:current_user) { current_user }

      render

      expect(rendered).to have_link "Log out", href: "/logout"
    end
  end
end
