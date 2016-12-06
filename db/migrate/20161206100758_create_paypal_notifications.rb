class CreatePaypalNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :paypal_notifications do |t|
      t.text :params
      t.integer :cart_id
      t.string :status
      t.string :transaction_id

      t.timestamps
    end
  end
end
