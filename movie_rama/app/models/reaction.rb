# This is a bit overengineered, but it's done on purpose for the sake of it
class Reaction < ApplicationRecord
  # Relationships
  has_many :movie_reactions, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :color, presence: true

  # Callbacks
  after_commit :clear_cache_movies_counts

  # Class methods
  class << self
    def reactions_mapping
      Rails.cache.fetch("reactions_mapping") do
        mapping = {}
        all.each { |r| mapping[r.name.to_sym] = r.id }

        mapping
      end
    end
  end

  private

  # The Association between reactions and movies is overengineered. In a real
  # productiont application it would not need that. Nevertheless, if we
  # would end up with a similar setup, this callback should execute and
  # asynchronous job that would clear the required cache keys.
  def clear_cache_movies_counts
    Rails.cache.delete_matched(/\d*_reaction_counts/)
    Rails.cache.delete("all_reactions")
    Rails.cache.delete("reactions_mapping")
  end
end

# == Schema Information
#
# Table name: reactions
#
#  id         :bigint           not null, primary key
#  color      :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
