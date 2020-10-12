module MovieReactionsHelper
  def reaction_link_to(reaction:, user:, movie:, umr: nil)
    options = if umr && (umr.reaction_id == reaction.id)
                delete_options(umr)
              elsif umr
                patch_options(umr, reaction.id)
              else
                post_options(reaction.id, user.id, movie.id)
              end

    generated_link(reaction, options)
  end

  def reaction_span_style(user_movie_reaction, reaction)
    if user_movie_reaction.try(:reaction_id) == reaction.id
      "color: #fff; background-color: #{reaction.color}; border: 1px solid #{reaction.color}"
    else
      "color: #{reaction.color}; border: 1px solid #{reaction.color}"
    end
  end

  private

  def generated_link(reaction, **options)
    link_text = reaction.name.pluralize.capitalize

    link_to(link_text, options[:url], method: options[:http_method], remote: true)
  end

  def delete_options(umr)
    {
      http_method: :delete,
      url: movie_reaction_path(umr)
    }
  end

  def patch_options(umr_id, reaction_id)
    {
      http_method: :patch,
      url: movie_reaction_path(
        umr_id,
        movie_reaction: { reaction_id: reaction_id }
      )
    }
  end

  def post_options(reaction_id, user_id, movie_id)
    {
      http_method: :post,
      url: movie_reactions_path(
        movie_reaction: {
          reaction_id: reaction_id,
          movie_id: movie_id,
          user_id: user_id
        }
      )
    }
  end
end
