class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :type
      t.integer :apartmentNumber
      t.integer :streetNumber
      t.string :streetName
      t.string :city
      t.string :province
      t.string :country
      t.string :postalCode

      t.timestamps
    end
  end
end
