require "rails_helper"

RSpec.describe MoviesController, type: :controller do
  context "Create movie" do
    before do
      @user = FactoryBot.create(:user)
      @params = { movie: { title: "movie", description: "description" } }
    end

    it "redirects to movies list after creation" do
      post :create, params: @params, session: { user_id: @user.id }

      is_expected.to redirect_to(movies_path)
    end
  end

  context "Update/Destroy movie" do
    render_views

    before do
      @movie = FactoryBot.create(:movie)
      @params = { movie: @movie.attributes.except("id", "created_at", "updated_at") }
      @other_user = FactoryBot.create(:user)
    end

    it "Redirects to movies list after update" do
      put :update,
          params: @params.merge(id: @movie.id),
          session: { user_id: @movie.user_id }

      is_expected.to redirect_to(movies_path)
    end
  end
end
