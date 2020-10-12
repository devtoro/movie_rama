class MovieReaction < ApplicationRecord
  # Relationships
  belongs_to :movie
  belongs_to :reaction
  belongs_to :user

  # Validations
  validates :movie_id, uniqueness: { scope: :user_id }
  validates :user_id, presence: true, on: :create
  validate  :user_not_movie_owner

  # Scopes

  # For each reaction we need a separated scope. Instead of passing the reaction
  # name/id as an a rgument to the scope, method_missing is used in order to
  # dynamically define a singleton_method on the MovieReaction class, based on
  # the reaction name that we want. This way, no mater how many reactions we
  # create, we can directly use the name of the reaction in order to fetch the
  # movie reactions of that reaction
  #
  # Used in Movie#reactions_count method
  class << self
    def method_missing(method, *args, &block)
      r_n = method.to_s.singularize.to_sym
      # If passed moethod not iincluded in existing reactions, return super
      return super unless Reaction.reactions_mapping.keys.include?(r_n)

      send(:define_singleton_method, method) do
        where(reaction_id: Reaction.reactions_mapping[r_n])
      end

      where(reaction_id: Reaction.reactions_mapping[r_n])
    end

    def respond_to_missing?(method_name, include_private = false)
      Reaction.reactions_mapping.keys.include?(method_name.to_s.singularize.to_sym) || super
    end
  end

  # Callbacks
  after_commit :clear_movie_reaction_counts

  # Instance methods
  def reaction_name
    Rails.cache.fetch("#{id}_mr_name") do
      reaction.name
    end
  end

  private

  def user_not_movie_owner
    # If movie is blank, the movie presence validation will add an error
    return unless movie && user_id == movie.user_id

    errors.add(:user_id, 'Movie owner cannot react to movie.')
  end

  # We cache movie reactions in order to avoid n+1 queries. For that reason
  # every time a new movie_reaction is created or updated or deleted, we need
  # to clear the respective cache key
  def clear_movie_reaction_counts
    Rails.cache.delete("#{movie_id}_reaction_counts")
    Rails.cache.delete("#{id}_mr_name")
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
