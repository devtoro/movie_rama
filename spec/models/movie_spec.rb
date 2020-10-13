require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).case_insensitive }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user).on(:create) }
    it { should validate_presence_of(:user_id) }
    it { should have_db_column(:user_id) }
  end

  context 'Scopes' do
    before do
      FactoryBot.create(:user)
      like = FactoryBot.create(:reaction, :like)
      hate = FactoryBot.create(:reaction, :hate)
      reaction = like
      4.times { |i| FactoryBot.create(:movie) }
      Movie.all.each_with_index do |movie, index|
        i = index + 1
        User.all.each do |user|
          next if user.id == movie.user_id

          if MovieReaction.where(movie: movie, reaction: like).count > i
            reaction = hate
          end

          MovieReaction.create(
            user: user,
            movie: movie,
            reaction: reaction
          )
        end
      end
    end
    let(:results) { true }

    it 'Should order movies according to likes desc' do
      movies = Movie.ordered(:like)
      movies.each_with_index do |movie, index|
        next if index == (movies.length - 1)

        movie_likes       = movie.reactions_count[:like]
        next_movie_likes  = movies[index + 1].reactions_count[:like]

        results = movie_likes >= next_movie_likes
      end

      expect(results).to eq(true)
    end

    it 'Should order movies according to likes asc' do
      movies = Movie.ordered(:like, :asc)
      movies.each_with_index do |movie, index|
        next if index == (movies.length - 1)

        movie_likes       = movie.reactions_count[:like]
        next_movie_likes  = movies[index + 1].reactions_count[:like]

        results = movie_likes <= next_movie_likes
      end

      expect(results).to eq(true)
    end

    it 'Should order movies according to hates desc' do
      movies = Movie.ordered(:hate)
      movies.each_with_index do |movie, index|
        next if index == (movies.length - 1)

        movie_hates       = movie.reactions_count[:hate]
        next_movie_hates  = movies[index + 1].reactions_count[:hate]

        results = movie_hates >= next_movie_hates
      end

      expect(results).to eq(true)
    end

    it 'Should order movies according to hates asc' do
      movies = Movie.ordered(:hate)
      movies.each_with_index do |movie, index|
        next if index == (movies.length - 1)

        movie_hates       = movie.reactions_count[:hate]
        next_movie_hates  = movies[index + 1].reactions_count[:hate]

        results = movie_hates <= next_movie_hates
      end

      expect(results).to eq(true)
    end

    it 'should only fetch movies of selected user' do
      user = User.first
      movies = Movie.user(user.id)
      movies_user_id = movies.map(&:user_id).uniq

      expect(movies_user_id.length).to eq(1)
      expect(movies_user_id.first).to eq(user.id)
    end
  end
end
