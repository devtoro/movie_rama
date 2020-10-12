require 'rails_helper'

RSpec.describe 'movies/_movies.html.haml' do
  let(:movie) { FactoryBot.create(:movie) }
  let(:reactions) { %i[like].map { |r| FactoryBot.create(:reaction, r) } }
  let(:user) { FactoryBot.create(:user) }

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
      expect(rendered).to have_text 'Likes'
    end

    it 'Has reactions buttons for any movie, except for ones shared by user' do
      view.stub(:current_user) { user }

      render  partial:
              'movies/movie.html.haml',
              locals: {
                movie: movie,
                reactions: reactions
              }

      expect(rendered).to have_link 'Likes', href: movie_reactions_path(
        movie_reaction: {
          reaction_id: reactions.first.id,
          movie_id: movie.id,
          user_id: user.id
        }
      )
    end
  end
end
