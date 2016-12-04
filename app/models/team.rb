class Team < ApplicationRecord
	belongs_to :tournament, inverse_of: :teams

	belongs_to :p1, :class_name => "Player" #, inverse_of: :team
	belongs_to :p2, :class_name => "Player" #, inverse_of: :team
	belongs_to :p3, :class_name => "Player" #, inverse_of: :team
	belongs_to :p4, :class_name => "Player" #, inverse_of: :team

	has_many :player

	#validates :tournament_id, presence: true
end
