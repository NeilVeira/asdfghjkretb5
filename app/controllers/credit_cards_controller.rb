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
        redirect_back payment_path(params[:ticket_id])
      end

      logger.debug "#{@credit_card.errors.count}"
      @credit_card.errors.full_messages.each do |msg|
        logger.debug "#{msg}"
      end
    end

  end
end
