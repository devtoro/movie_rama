# This is a bit overengineered, but it's done on purpose for the sake of it
class Reaction < ApplicationRecord
  # Relationships
  has_many :movie_reactions, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true

  # Class methods
  class << self
    def reactions_mapping
      Rails.cache.fetch('reactions_mapping') do
        mapping = {}
        all.each { |r| mapping[r.name.to_sym] = r.id }

        mapping
      end
    end
  end
end

# == Schema Information
#
# Table name: reactions
#
#  id         :bigint           not null, primary key
#  icon       :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
