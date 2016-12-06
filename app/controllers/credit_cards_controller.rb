class CreditCardsController < ApplicationController
  before_action :authenticate_user!

  def new
    @credit_card = CreditCard.new
    render 'new'
  end

  def create
    @credit_card = CreditCard.new(params.require(:credit_card).permit(:number, :cvc, :month, :year, :fname, :lname))
    @credit_card.person = current_person

    if CreditCard.existance(@credit_card.number, @credit_card.person.id)
      @credit_card.errors[:base] << "This card already exists!"
      render 'new'
    elsif @credit_card.save
		redirect_to paymentProcessing_path(params[:ticket_id],cc: @credit_card.id)
		#why would we want to redirect to profile?
		#case params[:direct]
		#  when "1"
		#    redirect_to paymentProcessing_path(params[:ticket_id],cc: @credit_card.id)
		#  when "3"
		#    redirect_to people_profile_path
		#  else
		#    redirect_to people_profile_path
		#end
    else
		render 'new'
		#why would we want to redirect to profile?
		#case params[:return]
		#  when "2"
		#    redirect_to payment_path(params[:ticket_id])
		#  when "3"
		#    redirect_to people_profile_path
		#  else
		#    render 'new'
		#end

      logger.debug "#{@credit_card.errors.count}"
      @credit_card.errors.full_messages.each do |msg|
        logger.debug "#{msg}"
      end
    end

  end

  def paymentProcessing
    # require 'stripe'

    ticket = Ticket.find(params[:id])
    price = get_price(ticket)

    @CC = CreditCard.where(id: params[:cc]).first
    unless @CC
      redirect_to payment_path
    end

    # Send requests to the gateway's test servers
    ActiveMerchant::Billing::Base.mode = :test

    # Create a new credit card object
    credit_card = ActiveMerchant::Billing::CreditCard.new(
        :number     => @CC.number ,
        :month      => @CC.month ,
        :year       => @CC.year ,
        :first_name => @CC.fname ,
        :last_name  => @CC.lname ,
        :verification_value  => @CC.cvc
    )

    if credit_card.valid?
      # Create a gateway object to the TrustCommerce service
      gateway = ActiveMerchant::Billing::StripeGateway.new(
          :login    => 'TestMerchant',
          :password => 'password'
      )

      # Authorize for $10 dollars (1000 cents)
      response = gateway.authorize(price, credit_card)

      if response.success?
        # Capture the money
        gateway.capture(price, response.authorization)
        # send_ticket ticket
        redirect_to ticket_path(params[:id])
      else
        logger.debug "credit card was not proccessed"
        # send_ticket ticket
        redirect_to ticket_path(params[:id])
        raise StandardError, response.message
      end

    end
    logger.debug "credit card was not valid"
    # send_ticket ticket
    redirect_to ticket_path(params[:id])
  end


end
