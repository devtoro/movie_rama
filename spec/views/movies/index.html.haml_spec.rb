RSpec.describe 'movies/index.html.haml' do
  context 'Top filters' do
    before(:each) do
      assign(:reactions, %w[like hate].map { |r| Reaction.create(name: r) })
      assign(:movies, [FactoryBot.create(:movie)])
    end

    it 'Has sorting option for date' do
      render

      expect(rendered).to have_link 'Date', href: '/movies?dir=desc&order=date'
    end
    it 'Has sorting options for all reactions that exist in the database' do
      render

      expect(rendered).to have_link 'Likes', href: '/movies?dir=desc&order=like'
      expect(rendered).to have_link 'Hates', href: '/movies?dir=desc&order=hate'
    end
  end
end
