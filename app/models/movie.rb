class Movie < ApplicationRecord
  # Relationships
  belongs_to :user, optional: true
  has_many :movie_reactions, dependent: :destroy

  # Validations
  validates_presence_of :title, :description, :user_id
  # If user is deleted, the movie should remain with user_id, but user will be blank
  # We might still want to be able to update the movie
  validates :user, presence: true, on: :create

  # Instance Methods
  def user_name
    Rails.cache.fetch("#{user_id}_full_name", expires_in: 1.hour) do
      user.try(:full_name)
    end
  end
end

# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_movies_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_2c7f519372  (user_id => users.id)
#
