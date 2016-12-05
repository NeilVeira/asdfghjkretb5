class Player < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	belongs_to :team #, inverse_of: :player

	validates :person_id, presence: true
	validates :tournament_id, presence: true
end
