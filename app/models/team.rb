class Team < ApplicationRecord
	belongs_to :tournament, inverse_of: :teams

	belongs_to :p1, :class_name => "Player"
	belongs_to :p2, :class_name => "Player"
	belongs_to :p3, :class_name => "Player"
	belongs_to :p4, :class_name => "Player"

	validates :tournament_id, presence: true
	validates :name, presence: true

end
