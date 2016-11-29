class CreditCardsController < ApplicationController
  before_action :authenticate_user!

  def new

  end

  def create
    @credit_card = CreditCard.new(params.require(:credit_card).permit(:number, :cvc, :month, :year, :fname, :lname))
    @credit_card.person = current_person
    if @credit_card.save

      if params[:direct] == "1"
        redirect_to paymentProcessing_path(params[:ticket_id],cc: @credit_card.id)
      else
        render people_profile_path
      end
    else
      if params[:return] == "2"
        redirect_to payment_path(params[:ticket_id])
      end

      logger.debug "#{@credit_card.errors.count}"
      @credit_card.errors.full_messages.each do |msg|
        logger.debug "#{msg}"
      end
    end

  end

  def paymentProcessing

    CC = CreditCard.where(id: params[:cc]).first
    unless CC
      redirect_to payment_path
    end
    # Send requests to the gateway's test servers
    ActiveMerchant::Billing::Base.mode = :test

    # Create a new credit card object
    credit_card = ActiveMerchant::Billing::CreditCard.new(
        :number     => CC.number ,
        :month      => CC.month ,
        :year       => CC.year ,
        :first_name => CC.fname ,
        :last_name  => CC.lname ,
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
        redirect_to ticket_path(params[:id])
      else
        logger.debug "credit card was not valid"
        redirect_to ticket_path(params[:id])
        raise StandardError, response.message
      end
    end
    logger.debug "credit card was not valid"
    redirect_to ticket_path(params[:id])
  end
end
