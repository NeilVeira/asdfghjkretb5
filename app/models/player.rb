class Player < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	has_one :team #, inverse_of: :player

	validates :person_id, presence: true
	validates :tournament_id, presence: true
end
