class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :dob
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
