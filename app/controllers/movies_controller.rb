class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end




  def index	
    if @movies == nil then @movies = Movie.all end	
    @all_ratings = ['G','PG','PG-13','R','NC-17']

#    if(param[:ratings.keys]!=nil)
#	{
#		@all_ratings.each{ |rate| 
#					filter[rate]=0;
#					};
#		param[:ratings.keys].each{ |elt| filter[elt]=1; }
#		@movies=@movies.where( ('rating'='G' and filter[G]='1') or ('rating'='PG' and filter[PG]='1') or ('rating'='PG-13' and filter[PG-13]='1') or ('rating'='R' and filter[R]='1') or ('rating'='NC-17' and filter[NC-17]='1'));
		
#	}
    #,-{ :class => (params[:sort_by] == "title" ? "hilite" : "th")}
    
    if (params[:sort_by] == "title"||params[:sort_by] == "date") then 		sort end
  end





  def sort
	if params[:sort_by] == "title" then @movies.sort!{ |a,b| a.title <=> b.title }
		
	elsif params[:sort_by] == "date" then @movies.sort!{ |a,b| a.release_date <=> b.release_date }
		
	end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
