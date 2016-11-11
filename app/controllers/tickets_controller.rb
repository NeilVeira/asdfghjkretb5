class TicketsController < ApplicationController
	before_action :authenticate_user!
	
    def index
		
    end
    
    def show
        @ticket = Ticket.find(params[:id])
    end
    
    def new
		@ticket = Ticket.new()
		@tournament = Tournament.find(session[:tournament_id])
    end
    
    def edit
    end
    
    def create
		@ticket = Ticket.new(ticket_params)
		@ticket.person = current_person
		@tournament = Tournament.find(session[:tournament_id])
		@ticket.tournament = @tournament
		logger.debug "params[:tickettype] = #{params[:tickettype]}"
		logger.debug "@ticket.tickettype = #{@ticket.tickettype}" 
		
		if @ticket.save
			#redirect_to controller create action doesn't work so use helper method to create objects
			if @ticket.tickettype == 1 
				logger.debug "creating player object"
				@player = create_player()
			elsif params[:tickettype] == 2 
				logger.debug "creating sponsor object"
				@sponsor = create_sponsor()
			end
			
			redirect_to @ticket
		else
			logger.error "Ticket was not added to database"
			render 'new'			
		end
    end
    
    def update
    end
    
    def destroy
    end
	
	def setup
		session[:tournament_id] = params[:id]		
		redirect_to new_ticket_path
	end
	
	private 
	def ticket_params
		params.require(:ticket).permit(:tickettype)
	end
	
end