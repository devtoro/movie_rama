RSpec.describe 'movies/_movies.html.haml' do
  let(:movie) { FactoryBot.create(:movie) }
  let(:reactions) { ['like'].map{ |r| Reaction.create(name: r) } }

  it 'Has link with movie user name value that works as filter' do
    render  partial: 'movies/movie.html.haml',
            locals: { movie: movie, reactions: reactions }

    expect(
      rendered
    ).to have_link movie.user_name, href: movies_path(user_id: movie.user_id)
  end

  context 'Reactions' do
    it 'Has reaction buttons disabled if user shared the respective movie' do
      view.stub(:current_user) { movie.user }

      render  partial:
              'movies/movie.html.haml',
              locals: {
                movie: movie,
                reactions: reactions
              }

      expect(rendered).not_to have_link 'Like', href: movie_reactions_path
      expect(rendered).to have_text 'Like'
    end

    it 'Has reactions buttons for any movie, except for ones shared by user' do
      view.stub(:current_user) { FactoryBot.create(:user) }

      render  partial:
              'movies/movie.html.haml',
              locals: {
                movie: movie,
                reactions: reactions
              }

      expect(rendered).to have_link 'Like', href: movie_reactions_path
    end
  end
end
