class PaypalNotificationsController < ApplicationController


  protect_from_forgery except: [:create]
  
  def create
    p_noti = PaypalNotification.create!(params: params, cart_id: params[:invoice], status:[:payment_status], transaction_id: params[:txn_id])
    ticket = Ticket.find(params[:invoice])
    if p_noti == false or p_noti == nil
      #logger.debug 'Creating PaypalNotification instance failed'
      logger.debug 'Creating PaypalNotification instance failed'
      ticket.has_paid=false
      ticket.save
      redirect_to ticket_path(params[:invoice])
    else
      params.permit!
      status = params[:payment_status]
      if status == "Completed"
        ticket.has_paid=true
        ticket.save
        logger.debug 'PayPal payment succeed'
        redirect_to ticket_path(params[:invoice])
      else
        logger.debug "PayPal payment was not sucessful"
        ticket.has_paid = false
        ticket.save
        redirect_to ticket_path(params[:invoice])
      end
    end
    #render nothing: true
  end
  
  
end