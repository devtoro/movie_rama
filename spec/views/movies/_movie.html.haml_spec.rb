RSpec.describe 'movies/_movies.html.haml' do
  context 'Reactions' do
    before(:each) do
      ['like'].each { |r| Reaction.create(name: r) }
    end

    it 'Has reaction buttons disabled if user shared the respective movie' do
      movie = FactoryBot.create(:movie)

      view.stub(:current_user) { movie.user }

      render partial: 'movies/movie.html.haml', locals: { movie: movie }

      expect(rendered).not_to have_link 'Like', href: movie_reactions_path
      expect(rendered).to have_text 'Like'
    end

    it 'Has reactions buttons for any movie, except for ones shared by user' do
      movie = FactoryBot.create(:movie)

      view.stub(:current_user) { FactoryBot.create(:user) }

      render partial: 'movies/movie.html.haml', locals: { movie: movie }

      expect(rendered).to have_link 'Like', href: movie_reactions_path
    end
  end
end
