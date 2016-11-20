class CreateCreditCardTable < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_card_tables do |t|
      t.references :person, foreign_key: true
      t.integer :number
      t.integer :month
      t.integer :year
      t.integer :cvc
      t.string :fname
      t.string :lname
    end
  end
end
