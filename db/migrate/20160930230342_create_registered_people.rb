class CreateRegisteredPeople < ActiveRecord::Migration[5.0]
  def change
    create_table :registered_people do |t|
      t.references :person, foreign_key: true
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
