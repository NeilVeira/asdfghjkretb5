class TournamentOrganizer < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	validates :person_id, presence: true
	validates :tournament_id, presence: true
	validates :adminrights, presence: true
end
