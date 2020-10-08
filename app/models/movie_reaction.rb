class MovieReaction < ApplicationRecord
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
