class Movie < ApplicationRecord
  # Relationships
  belongs_to :user, optional: true
  has_many :movie_reactions, dependent: :destroy

  # Validations
  validates_presence_of :title, :description, :user_id
  # If user is deleted, the movie should remain with user_id, but user will be blank
  # We might still want to be able to update the movie
  validates :user, presence: true, on: :create

  # Scopes
  scope :ordered, ->(order = 'publication', direction = 'desc') do
    case order
    when 'publication'
      order(created_at: direction)
    else
      r_id = Reaction.reactions_mapping[order.to_s.singularize.to_sym]
      joins(:movie_reactions)
        .group('movies.id')
        .order("COUNT(movie_reactions.reaction_id) #{direction.to_s.upcase}")
        .where('movie_reactions.reaction_id = ?', r_id)
    end
  end

  # Instance Methods
  def user_name
    Rails.cache.fetch("#{user_id}_full_name", expires_in: 1.hour) do
      user.try(:full_name)
    end
  end

  def movie_reactions_count
    Rails.cache.fetch("#{id}_reaction_counts") do
      m_r_counts = {}
      Reaction.reactions_mapping.each do |k, v|
        m_r_counts[k] = movie_reactions.send(k).count
      end

      m_r_counts
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
