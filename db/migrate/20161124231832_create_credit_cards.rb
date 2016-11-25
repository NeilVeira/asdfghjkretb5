class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.references :person, foreign_key: true

      t.integer :number
      t.integer :month
      t.integer :year
      t.integer :cvc
      t.string :fname
      t.string :lname

      t.timestamps
    end
  end
end
