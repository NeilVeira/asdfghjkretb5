class CreateRegisteredTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :registered_teams do |t|
      t.string :name
      t.references :person, foreign_key: true
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
