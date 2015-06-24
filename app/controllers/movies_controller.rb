class MoviesController < ApplicationController

  def index
    @movies = Movie.where("title LIKE ?", "%#{params[:title]}%").where("director LIKE ?", "%#{params[:director]}%")

  # <%= select_tag(:duration, options_for_select([
    # ['Under 90 minutes', 1], 
    # ['Between 90 and 120 minutes', 2],
    #  ['Over 120 minutes', 3]])) %>
    case params[:duration]
    when 1
      @movies = @movies.where("duration < 90")
    when 2
      @movies = @movies.where("duration BETWEEN 90 AND 120")
    when 3
      @movies = @movies.where("duration > 120")
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end

end