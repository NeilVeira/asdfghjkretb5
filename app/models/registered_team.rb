class RegisteredTeam < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	validates :person_id, presence: true
	validates :name, presence: true
	validates :tournament_id, presence: true
end
