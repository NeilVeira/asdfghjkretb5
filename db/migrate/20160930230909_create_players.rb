class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.references :person, foreign_key: true
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
