class NotRegisteredValidator < ActiveModel::Validator
	def validate(record)
		if record.person
			ticket = Ticket.find_by(person_id: record.person.id, tournament_id: record.tournament.id)
			if ticket
				record.errors[:base] << "User #{record.person.user.email} is already registered for this tournament"
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

