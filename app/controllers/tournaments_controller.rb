class TournamentsController < ApplicationController
	def index
		@tournaments = Tournament.all
		@tournaments.each do |t|
			t.date = Date.new(2017,2,3) #Note: this line should be destroyed later, but I need it for testing. - Anthony
		end
	end
  
	def new
		@tournament = Tournament.new
	end
  
	def create
		@tournament = Tournament.new(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures, :date))
		if @tournament.save
			redirect_to @tournament
		else
			render 'new'
		end
	end
  
	def show
		@tournament = Tournament.find(params[:id])
		@tournament.date = Date.new(2017,2,3)  # Note: this line should be destroyed later, but I need it for testing. - Anthony
	end
	
	def edit
		@tournament = Tournament.find(params[:id])
	end
  
	def update
		@tournament = Tournament.find(params[:id])		
		if @tournament.update(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures, :date))		
			redirect_to @tournament
		else
			render 'edit'
		end
	end
	
	def destroy
		@tournament = Tournament.find(params[:id])
		@tournament.destroy
		redirect_to tournaments_path
	end
end
