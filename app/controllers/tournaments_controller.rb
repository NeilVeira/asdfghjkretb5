class TournamentsController < ApplicationController
	def index
		@tournaments = Tournament.all
	end
  
	def new
	end
  
	def create
		@tournament = Tournament.new(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures))
		@tournament.save
		redirect_to @tournament
	end
  
	def show
		@tournament = Tournament.find(params[:id])
	end
	
	def edit
		@tournament = Tournament.find(params[:id])
	end
  
	def update
		@tournament = Tournament.find(params[:id])
		@tournament.update(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures))
		redirect_to @tournament
	end
	
	def destroy
		@tournament = Tournament.find(params[:id])
		@tournament.destroy
		redirect_to tournaments_path
	end
end
