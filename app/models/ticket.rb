class Ticket < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	validates :tickettype, presence: true
	validates :person_id, presence: true
	validates :tournament_id, presence: true
end
