class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :tournament, foreign_key: true
      t.references :p1
      t.references :p2
      t.references :p3
      t.references :p4

      t.timestamps
    end
  end
end
