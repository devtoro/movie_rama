class MoviesController < SecureController
  before_action :set_reactions, except: :destroy

  def index
    i_params  = index_params
    order     = i_params[:order] || 'date'
    dir       = i_params[:dir] || 'desc'
    @dir      = dir == 'desc' ? 'asc' : 'desc'
    @movies   = Movie
                .includes(:user)
                .user(i_params[:user_id])
                .ordered(order, dir)
  end

  def show; end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params.merge(user: current_user)

    if @movie.save
      flash[:success] = "Movie #{@movie.title} created successfully"
      redirect_to movies_path
    else
      respond_to do |format|
        format.js {}
      end
    end
  end

  def edit; end

  def update
    if authorize_movie && @movie.update(movie_params)
      flash[:success] = "Movie #{@movie.title} created successfully"
      redirect_to movies_path
    else
      respond_to do |format|
        format.js {}
      end
    end
  end

  def destroy
    if authorize_movie && @movie.destroy
      flash[:success] = "Movie #{@movie.title} deleted successfully"
      redirect_to movies_path
    else
      flash[:error] = @movie.errors.messages
      render :destroy, status: 422
    end
  end

  private

  def index_params
    params.permit(:order, :dir, :user_id)
  end

  def movie_params
    params.require(:movie).permit(
      :title, :description, :user_id
    )
  end

  def set_reactions
    @reactions = Reaction.all
  end

  def authorize_movie
    return true if @movie.user_id == current_user.try(:id)

    raise UnauthorizedException
  end
end
