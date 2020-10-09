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

      link1 = have_link('Likes', href: '/movies?dir=desc&order=like')
      link2 = have_link('Likes', href: '/movies?dir=asc&order=like')
      link3 = have_link('Hates', href: '/movies?dir=desc&order=hate')
      link4 = have_link('Hates', href: '/movies?dir=asc&order=hate')

      expect(rendered).to link1 || link2
      expect(rendered).to link3 || link4
    end
  end
end
