class NotRegisteredValidator < ActiveModel::Validator
	def validate(record)
		if record.person
			ticket = Ticket.find_by(person_id: record.person.id, tournament_id: record.tournament.id)
			if ticket
				if ticket.tickettype == 4
					#Special case when user creates a new tournament, a ticket with tickettype 4 
					#exists but we still need to create a tournament_organizer.
					#If no tournament organizer object exists for this user, pass validation
					to = TournamentOrganizer.find_by(person_id: record.person.id, tournament_id: record.tournament.id)
					if to
						record.errors[:base] << "User #{record.person.user.email} is already registered for this tournament"
					end
				else
					record.errors[:base] << "User #{record.person.user.email} is already registered for this tournament"
				end
			end
		else
			record.errors[:base] << "User not found"
		end
	end
end

class TournamentOrganizer < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	#validates :person_id, presence: {message: "User not found"}
	validates :tournament_id, presence: true
	validates :adminrights, presence: true
	validates_with NotRegisteredValidator
end

