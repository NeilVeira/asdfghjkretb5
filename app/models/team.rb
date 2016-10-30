class Team < ApplicationRecord
	belongs_to :tournament
	
	validates :tournament_id, presence: true
	validates :name, presence: true
end
