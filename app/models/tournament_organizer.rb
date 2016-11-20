class NotRegisteredValidator < ActiveModel::Validator
	def validate(record)
		ticket = Ticket.find_by(person_id: record.person.id, tournament_id: record.tournament.id)
		if ticket
			record.errors[:base] << "Person is already registered for tournament"
		end
	end
end

class TournamentOrganizer < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	validates :person_id, presence: true
	validates :tournament_id, presence: true
	validates :adminrights, presence: true
	validates_with NotRegisteredValidator
end

