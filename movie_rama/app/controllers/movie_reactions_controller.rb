class MovieReactionsController < SecureController
  before_action :set_movie_reaction, only: %i[update destroy]

  def create
    @mr = MovieReaction.new(movie_reaction_params)

    if @mr.save
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = @mr.errors.messages
      render template: "movies/index", status: 422
    end
  end

  def update
    if @mr.update_attributes(movie_reaction_params)
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = @mr.errors.messages
      render template: "movies/index", status: 422
    end
  end

  def destroy
    if @mr.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = @mr.errors.messages
      render template: "movies/index", status: 422
    end
  end

  private

  def movie_reaction_params
    params.require(:movie_reaction).permit(
      :user_id,
      :movie_id,
      :reaction_id
    )
  end

  def set_movie_reaction
    @mr = MovieReaction.find(params[:id])
  end
end
