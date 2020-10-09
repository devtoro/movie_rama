class MoviesController < SecureController
  def index
    @reactions = Reaction.all
    @movies = Movie.includes(:user).all
  end
end
