class Reaction < ApplicationRecord
  # Relationships
  has_many :movie_reactions, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true
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
