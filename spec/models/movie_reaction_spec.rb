require 'rails_helper'

RSpec.describe MovieReaction, type: :model do
  context 'Validations' do
    subject do
      user      = FactoryBot.create :user
      movie     = FactoryBot.create :movie, user: user
      reaction  = FactoryBot.create :reaction, :like
      MovieReaction.new(movie: movie, reaction: reaction, user: user)
    end

    it { should have_db_column(:user_id) }
    it { should have_db_column(:reaction_id) }
    it { should have_db_column(:movie_id) }
    it { should belong_to(:user) }
    it { should belong_to(:reaction) }
    it { should belong_to(:movie) }
    it { should validate_uniqueness_of(:movie_id).scoped_to(:user_id) }
    it 'Should not be created by the user who created the movie it is related with' do
      subject.valid?
      expect(subject.errors.messages.blank?).to_not eq(true)
    end
  end

  context 'Reactions count singleton method' do
    before do
      %w[like hate].each { |r| Reaction.create(name: r) }
    end

    it 'Responds to random ame, same as an existing reaction' do
      responds = MovieReaction.respond_to? :hate
      expect(responds).to eq(true)
    end

    it 'Does not respond to random method, that does not match an existng reaction name' do
      responds = MovieReaction.respond_to? :sad
      expect(responds).to eq(false)
    end
  end
end
