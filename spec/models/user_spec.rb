require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) { FactoryBot.build(:user) }
  let(:user_with_falsy_email) { FactoryBot.build(:user, :with_falsy_email) }

  context 'Validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }

    it 'Expexts user email to have proper format, otherwise User should be invalid' do
      user_with_falsy_email.valid?
      expect(user_with_falsy_email.errors[:email]).to include('is invalid')
    end

    it 'Expects User with full_name, email and password to be valid' do
      valid_user.valid?
      expect(valid_user.errors.messages.blank?).to eq(true)
    end
  end

  context 'Instance methods' do
    before do
      user1     = FactoryBot.create :user
      user2     = FactoryBot.create :user
      movie1    = FactoryBot.create :movie, user: user2
      FactoryBot.create :movie, user: user2
      reaction  = FactoryBot.create :reaction, :like
      MovieReaction.create(movie: movie1, reaction: reaction, user: user1)
    end

    it 'Should show like for example user and movie1' do
      mr = MovieReaction.first
      movie = mr.movie
      user = mr.user
      r = user.check_reaction(movie_id: movie.id)

      expect(r.id).to eq(mr.id)
    end

    it 'Should show false for example user and movie2' do
      r = User.first.check_reaction(movie_id: User.last.movies.last.id)

      expect(r).to eq(nil)
    end
  end
end
