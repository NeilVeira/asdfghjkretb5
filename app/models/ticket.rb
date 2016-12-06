class Ticket < ApplicationRecord
	belongs_to :person
	belongs_to :tournament


	validates :tickettype, presence: true, inclusion: {in: [1,2,3,4], 
											message: "tickettype must be integer in range 1-4"}
	validates :person_id, presence: true, uniqueness: { scope: :tournament_id,
											messsage: "Already registered" }
	validates :tournament_id, presence: true, uniqueness: { scope: :person_id,
											messsage: "You are already registered" }
											
	 def paypal_url(return_url, t_id, t_price)
    values = {
      business: 'castiel.x.zhu-merchant@gmail.com',
      cmd: '_xclick',
      upload: 1,
      return: return_url,
      invoice: id,
      amount: t_price.to_s,
      #amount: get_price(@ticket).to_s,
      item_name: 'golf_ticket, id:' +t_id.to_s,
      item_number: '1',
      quantity: '1',
      #{Rails.application.secrets.app_host}
      notify_url: "http://b519b63b.ngrok.io/paypal_pay"
    }
    "https://www.sandbox.paypal.com/cig-bin/webscr?"+ values.to_query
  end   
  
end
