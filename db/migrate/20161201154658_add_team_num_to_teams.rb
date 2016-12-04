class AddTeamNumToTeams < ActiveRecord::Migration[5.0]
  def change
	add_column :teams, :team_num, :integer
  end
end
