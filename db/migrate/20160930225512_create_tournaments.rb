class CreateTournaments < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.text :description
      t.boolean :ispublic
      t.text :extrafeatures

      t.timestamps
    end
  end
end
