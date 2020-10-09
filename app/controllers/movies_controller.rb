class MoviesController < SecureController
  def index
    @reactions = Reaction.all

    i_params = index_params
    order = i_params[:order] || 'date'
    dir   = i_params[:dir] || 'desc'

    @dir  = dir == 'desc' ? 'asc' : 'desc'
    @movies = Movie
              .includes(:user)
              .ordered(order, dir)
  end

  def index_params
    params.permit(:order, :dir)
  end
end
