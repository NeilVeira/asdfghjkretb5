class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.string :name
      t.string :team
      t.string :golfcourse
      t.string :tournament
      t.string :location
      t.integer :score
      t.integer :hole

      t.timestamps
    end
  end
end
