class CreateTournamentOrganizers < ActiveRecord::Migration[5.0]
  def change
    create_table :tournament_organizers do |t|
      t.references :person, foreign_key: true
      t.references :tournament, foreign_key: true
      t.integer :adminrights

      t.timestamps
    end
  end
end
