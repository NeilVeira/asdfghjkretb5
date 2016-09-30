class CreateSponsors < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsors do |t|
      t.references :person, foreign_key: true
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
