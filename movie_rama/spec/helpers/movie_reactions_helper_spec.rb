require "rails_helper"

RSpec.describe MovieReactionsHelper, type: :helper do
  # user1 and user2 are not the owners of the movie
  # user2 has reacted on movie, user1 has not
  let(:like) { FactoryBot.create(:reaction, :like) }
  let(:hate) { FactoryBot.create(:reaction, :hate) }
  let(:movie) { FactoryBot.create(:movie) }
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:movie_reaction) do
    MovieReaction.create(movie: movie, reaction: like, user: user2)
  end

  context "Reaction link to" do
    # link generated for user2
    it "Returns correct link for view - CREATE" do
      url_path_params = {
        movie_reaction: {
          reaction_id: like.id, movie_id: movie.id, user_id: user1.id,
        },
      }
      correct_link = link_to(
        like.name.pluralize.capitalize,
        movie_reactions_path(url_path_params),
        method: :post,
        remote: true,
      )

      generated_link = reaction_link_to(reaction: like, user: user1, movie: movie)
      expect(correct_link).to eq(generated_link)
    end

    # link generated for user1, for other than created
    it "Returns correct link for view - UPDATE" do
      url_path_params = {
        movie_reaction: {
          reaction_id: hate.id,
        },
      }
      correct_link = link_to(
        hate.name.pluralize.capitalize,
        movie_reaction_path(movie_reaction.id, url_path_params),
        method: :patch,
        remote: true,
      )

      generated_link = reaction_link_to(
        reaction: hate, user: user2, movie: movie, umr: movie_reaction,
      )
      expect(correct_link).to eq(generated_link)
    end

    # link generated for user1, for the created one
    it "Returns correct link for view - DELETE" do
      correct_link = link_to(
        like.name.pluralize.capitalize,
        movie_reaction_path(movie_reaction.id),
        method: :delete,
        remote: true,
      )

      generated_link = reaction_link_to(
        reaction: like, user: user2, movie: movie, umr: movie_reaction,
      )
      expect(correct_link).to eq(generated_link)
    end
  end
end
