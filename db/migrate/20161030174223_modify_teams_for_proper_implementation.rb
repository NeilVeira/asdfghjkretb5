class ModifyTeamsForProperImplementation < ActiveRecord::Migration[5.0]
  def change
	add_reference :teams, :p1, foreign_key: true
	add_reference :teams, :p2, foreign_key: true
	add_reference :teams, :p3, foreign_key: true
	add_reference :teams, :p4, foreign_key: true
  end
end
