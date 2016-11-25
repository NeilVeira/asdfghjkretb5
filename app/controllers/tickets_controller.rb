class TicketsController < ApplicationController
	before_action :authenticate_user!
	require 'rqrcode'

    def index
		
    end
    
    def show
        @ticket = Ticket.find(params[:id])
		@code = @ticket.tournament_id.to_s + "-" + @ticket.id.to_s
		@qrcode = RQRCode::QRCode.new(@code)
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

  	def qrcode

		end

  	def payment
      # @CreditCard = CreditCard.new
    end

  def paymentProcessing
    # Send requests to the gateway's test servers
    ActiveMerchant::Billing::Base.mode = :test

# Create a new credit card object
    credit_card = ActiveMerchant::Billing::CreditCard.new(
        :number     => params[:number],
        :month      => params[:month],
        :year       => params[:year],
        :first_name => params[:fname],
        :last_name  => params[:lname],
        :verification_value  => '123'
    )

    if credit_card.valid?
      # Create a gateway object to the TrustCommerce service
      gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
          :login    => 'TestMerchant',
          :password => 'password'
      )

      # Authorize for $10 dollars (1000 cents)
      response = gateway.authorize(1000, credit_card)

      if response.success?
        # Capture the money
        gateway.capture(1000, response.authorization)
      else
        raise StandardError, response.message
      end
    end
  end

	private
		def ticket_params
			params.require(:ticket).permit(:tickettype)
		end
	
end