class Ticket < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	validates :tickettype, presence: true, inclusion: {in: [1,2,3,4], 
											message: "tickettype must be integer in range 1-4"}
	validates :person_id, presence: true, uniqueness: { scope: :tournament_id,
											messsage: "Already registered" }
	validates :tournament_id, presence: true, uniqueness: { scope: :person_id,
											messsage: "You are already registered" }
end
