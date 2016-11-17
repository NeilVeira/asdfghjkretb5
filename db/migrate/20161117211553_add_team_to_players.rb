class AddTeamToPlayers < ActiveRecord::Migration[5.0]
	def change
		add_reference :players, :team, foreign_key: true
	end
end
