class RemoveNameFromTeam < ActiveRecord::Migration[5.0]
	def change
		remove_column :teams, :name, :string
	end
end
