class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :tickettype
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
