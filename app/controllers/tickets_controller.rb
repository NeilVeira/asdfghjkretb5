class TicketsController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_ticket_owner!, only: [:show]
	before_action :authenticate_admin!, only: [:index, :edit, :update]

    def index
		
    end
    
    def show
        @ticket = Ticket.find(params[:id])
				get_qrcode @ticket
    end
    
    def new
		@ticket = Ticket.new()
		@tournament = Tournament.find(session[:tournament_id])

    end
    
    def edit
    end
    
    def create
		@ticket = create_ticket(ticket_params[:tickettype])
		if @ticket
			case @ticket.tickettype 
				when 1
					redirect_to payment_path(@ticket.id)
				when 2
					redirect_to new_sponsor_path
				else
					redirect_to ticket_path(@ticket)
				end
		else
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

  	def check_in
			@ticket = Ticket.find(params[:id])
			if (is_current_tournament_organizer @ticket.tournament.id)
				@ticket.checked_in = true
			else
				render 'ticket_error'
			end
		end

  	def payment

		end

	private
		def ticket_params
			params.require(:ticket).permit(:tickettype)
		end

		def is_current_tournament_organizer (t_id = session[:tournament_id])
			if TournamentOrganizer.where(tournament_id: t_id, person_id: current_person.id).any?
				true
			else
				false
			end
		end

		def authenticate_ticket_owner!
			#check that current user is the owner of this ticket
			@ticket = Ticket.find(params[:id])
			@person = current_person
			if not user_is_admin? and @person != @ticket.person
				access_denied
			end
		end

end