class MovieReaction < ApplicationRecord
  # Relationships
  belongs_to :movie
  belongs_to :reaction
  belongs_to :user

  # Validations
  validates :movie_id, uniqueness: { scope: :user_id }
  validates :user_id, presence: true, on: :create
  validate  :user_not_movie_owner

  private

  def user_not_movie_owner
    # If movie is blank, the movie presence validation will add an error
    return unless movie && user_id == movie.user_id

    errors.add(:user_id, 'Movie owner cannot react to movie.')
  end
end

# == Schema Information
#
# Table name: movie_reactions
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  movie_id    :bigint           not null
#  reaction_id :integer          not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_movie_reactions_on_movie_id                  (movie_id)
#  index_movie_reactions_on_movie_id_and_reaction_id  (movie_id,reaction_id)
#  index_movie_reactions_on_movie_id_and_user_id      (movie_id,user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_943c14353d  (user_id => users.id) ON DELETE => cascade
#
