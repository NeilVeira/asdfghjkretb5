class TournamentOrganizersController < ApplicationController
	before_action :authenticate_organizer!, only: [:new, :create, :edit, :update]
	before_action :authenticate_admin!, only: [:index, :show]
	
	def index
		@tournament_organizers = TournamentOrganizer.all
    end
    
    def show
    	@tournament_organizer = TournamentOrganizer.find(params[:id])
		redirect_to @tournament_organizer.person
    end 
    
    def new #display the for new record
		if session[:tournament_id]
			@tournament = Tournament.find(session[:tournament_id])
			@organizer = TournamentOrganizer.find_by(tournament_id: @tournament.id, person_id: current_person.id)
			@tournament_organizer = TournamentOrganizer.new()
		else
			access_denied
		end
    end
    
    def create #save new record
    	@tournament_organizer = TournamentOrganizer.new()
		@tournament = Tournament.find(session[:tournament_id])
		
		#construct adminrights bitvector
		adminrights = 0
		if params[:tournament_organizer_key][:edit_privilege] == "1"
			adminrights = adminrights | (1<<0)
		end
		if params[:tournament_organizer_key][:tee_sheet_privilege] == "1"
			adminrights = adminrights | (1<<1)
		end
		if params[:tournament_organizer_key][:create_admin_privilege] == "1"
			adminrights = adminrights | (1<<2)
		end
		logger.debug "setting adminrights = #{adminrights}"
		@tournament_organizer.adminrights = adminrights
		
		#try to find this person in the database
		user = User.find_by(email: params[:tournament_organizer_key][:email])
		if user
			logger.debug "found user"
			person = Person.find_by(user_id: user.id)
			logger.debug "Found person #{person.firstname} #{person.lastname}"
			@tournament_organizer.person = person
		else
			#do nothing - should fail validation
			logger.debug "No user found"
		end
		
		@tournament_organizer.tournament = @tournament

    	if @tournament_organizer.save
			logger.debug "tournament_organizer saved successfully"
			#create a ticket for this organizer
			ticket = Ticket.new()
			ticket.person = @tournament_organizer.person
			ticket.tournament = @tournament
			ticket.tickettype = 4 #organizer
			if ticket.save
				logger.debug "ticket saved successfully"
				#go back to dashboard
				redirect_to "/tournaments/#{session[:tournament_id]}/dashboard"
			else
				#this shouldn't happen, but handle it just in case...
				logger.debug "ticket was not added to database"
				@tournament_organizer.destroy
				redirect_to new_tournament_organizer_path #go back to new if save not 
			end
    	else
			logger.debug "tournament_organizer not added to database"
    		#redirect_to new_tournament_organizer_path #go back to new if save not successful
			@organizer = TournamentOrganizer.find_by(tournament_id: @tournament.id, person_id: current_person.id)
			render 'new'
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
		
		def authenticate_organizer!
			#make sure the current user is an organizer for this tournament. If not, display an access denied message and redirect to home
			unless user_is_organizer?(session[:tournament_id])
				access_denied
			end
	end
	
end

