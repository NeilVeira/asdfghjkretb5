class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :tickettype #player=1, sponser=2, audience=3
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
