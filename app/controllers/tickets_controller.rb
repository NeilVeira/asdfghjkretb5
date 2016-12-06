class TicketsController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_ticket_owner!, only: [:show, :destroy, :payment, :payment_select, :paypal_pay, :check_in]
	before_action :authenticate_admin!, only: [:index, :edit, :update]

    def index
		
    end
    
    def show
        @ticket = Ticket.find(params[:id])
		@code = checkIn_url(id:@ticket.id).to_s
		@qrcode = RQRCode::QRCode.new(@code)
    end
    
    def new
		@ticket = Ticket.new()
		@tournament = Tournament.find(session[:tournament_id])
		person = current_person
		exists_ticket = Ticket.where(tournament_id: session[:tournament_id], person: person).first
		if exists_ticket
			redirect_to ticket_path(exists_ticket)
		end
    end
    
    def edit
    end
    
    def create
		@ticket = create_ticket(ticket_params[:tickettype])
		if @ticket
			case @ticket.tickettype 
				when 1
          if (@ticket.tournament.pricePlayer != nil && @ticket.tournament.pricePlayer > 0) 
            redirect_to payment_select_path(@ticket.id)
          else 
            redirect_to ticket_path(@ticket.id)
          end
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
				render 'check_in'
			else
				render 'ticket_error'
			end
		end

  	def payment
		  @cc = CreditCard.where(person_id: current_person.id)
  	end
  		
  	def payment_select
      
    end
    
    def paypal_pay
      @paypal_noftication = PaypalNotification.create!
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