class TicketsController < ApplicationController
	before_action :authenticate_user!
	require 'rqrcode'

    def index
		
    end
    
    def show
        @ticket = Ticket.find(params[:id])
				@qrcode = RQRCode::QRCode.new(@ticket.tournament_id.to_s + "-" + @ticket.id.to_s)
    end
    
    def new
			@ticket = Ticket.new()
			@tournament = Tournament.find(session[:tournament_id])
    end
    
    def edit
    end
    
    def create
			@ticket = create_ticket(ticket_params[:tickettype])
			if @ticket and @ticket.tickettype == 1
				redirect_to payment_path(@ticket.id)
			elsif @ticket
				redirect_to ticket_path(@ticket)
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

  	def payment

		end

	private
		def ticket_params
			params.require(:ticket).permit(:tickettype)
		end
	
end