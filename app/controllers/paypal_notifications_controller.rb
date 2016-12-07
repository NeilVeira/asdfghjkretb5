class PaypalNotificationsController < ApplicationController
before_action :authenticate_user!
"""
In order to get full PayPal support,
first download ngrok (version 2.x required),
then run ngrok http 3000, 
you will get a URL,
in your ticket model, replace the 'notify_url' with your own URL
Now your localhost:3000 is tunneled to Ngrok subdomain,
and your application is supposed to be able to receive HTTP POST from PayPal.
"""
  
  protect_from_forgery except: [:create]
  
  def create
    p_noti = PaypalNotification.create!(params: params, cart_id: params[:invoice], status:[:paypal_status], transaction_id: params[:txn_id])
    print 'after p_noti, line 17'
    ticket = Ticket.find(params[:invoice])
    if p_noti == flase or p_noti == nil
      #logger.debug 'Creating PaypalNotification instance failed'
      logger.debug 'Creating PaypalNotification instance failed'
      ticket.has_paid=false
      ticket.save
      #redirect_to ticket_path(params[:invoice])
    else
      params.permit!
      status = params[:paypal_status]
      if status == "Completed"
        ticket.has_paid=true
        ticket.save
        logger.debug 'PayPal payment succeed'
        #redirect_to ticket_path(params[:invoice])
      else
        logger.debug "PayPal payment was not sucessful"
        ticket.has_paid=false
        ticket.save
        #redirect_to ticket_path(params[:invoice])
      end
    end
    render nothing: true
  end
  
  
end