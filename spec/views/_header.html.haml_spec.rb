RSpec.describe 'layouts/_header.html.haml' do
  context 'Profile section' do
    it 'Shows login/signup buttons if user not authenticated'
    it 'Shows welcome message if user is authenticated'
    it 'Shows "New Movie" button if user is authenticated'
  end
end
