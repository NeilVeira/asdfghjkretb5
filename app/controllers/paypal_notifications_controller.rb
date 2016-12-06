class PaypalNotificationsController < ApplicationController
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
    PaypalNotification.create!(params: params, cart_id: params[:invoice], status:[:paypal_status], transaction_id: params[:txn_id])
    render nothing: true
  end
  
end
