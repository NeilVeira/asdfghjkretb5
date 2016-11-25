class Ticket < ApplicationRecord
	belongs_to :person
	belongs_to :tournament

	attr_accessor :number, :month, :year, :cvc, :amount, :fname, :lname
	validates :number, allow_blank: true, length: {in: 14..18} # dunno how long standard credit cards are but approx
	validates :month, allow_blank: true, numericality: true
	validates :year, allow_blank: true, numericality: true
	validates :cvc, allow_blank: true, numericality: true
	validates :amount, allow_blank: true, numericality: true

	validates :tickettype, presence: true, inclusion: {in: [1,2,3,4], 
											message: "tickettype must be integer in range 1-4"}
	validates :person_id, presence: true, uniqueness: { scope: :tournament_id,
											messsage: "Already registered" }
	validates :tournament_id, presence: true, uniqueness: { scope: :person_id,
											messsage: "You are already registered" }
end
