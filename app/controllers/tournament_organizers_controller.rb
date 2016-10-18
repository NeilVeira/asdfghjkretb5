class TournamentOrganizersController < ApplicationController

	def index
		@tournament_organizers = TournamentOrganizer.all
    end
    
    def show
    	@tournament_organizer = TournamentOrganizer.find(params[:id])
		redirect_to @tournament_organizer.person
    end 
    
    def new #display the for new record
    	@tournament_organizer = TournamentOrganizer.new
    end
    
    def create #save new record
    	@tournament_organizer = TournamentOrganizer.new(tournament_organizer_params)

    	if @tournament_organizer.save 
    		redirect_to golf_course_organizers_path	
    	else
    		redender 'new' #go back to new if save not successful
    	end
    end
    
    def edit #display form for existing record
    	@tournament_organizer = TournamentOrganizer.find(params[:id])
    end
    
    def update #save changes
    	@tournament_organizer = TournamentOrganizer.find(params[:id])
		@tournament_organizer.update(tournament_organizer_params)
		redirect_to @tournament_organizer
    end
    
    def destroy #destroy record
		@tournament_organizer = TournamentOrganizer.find(params[:id])
		@tournament_organizer.destroy
		redirect_to tournament_organizers_path
   	end

    private
		def tournament_organizer_params
			params.require(:tournament_organizer).permit(:person, :tournament, :adminrights)
		end
	
end

