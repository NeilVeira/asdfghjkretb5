class Ticket < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	validates :tickettype, presence: true
	validates :person_id, presence: true, uniqueness: { scope: :tournament_id,
											messsage: "Already registered" }
	validates :tournament_id, presence: true, uniqueness: { scope: :person_id,
											messsage: "You are already registered" }
end
