class MoviesController < ApplicationController

  def index
    
    @movies = Movie.search(params[:search])

    case params[:duration]
    when 'under_niney'
      @movies = Movie.under_90_minutes
    when 'mid_length'
      @movies = Movie.between_90_and_120_minutes
    when 'over_120'
      @movies = Movie.over_120_minutes
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