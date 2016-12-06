class PaypalNotification < ApplicationRecord
#  belongs_to :ticket
  serialize :params
  after_create :mark_as_purchased
  
  def mark_as_purchased
    params.permit!
    status = params[:paypal_status]
    if status == "Completed"
      #redirect_to ticket_path(params[:id])
      print 'paypal pay succeed'
    else
      #redirect_to ticket_path(params[:id])
      print 'paypal pay failed'
      raise StandardError, response.message
    end
  end

end
