class AddAddressToPeople < ActiveRecord::Migration[5.0]
  def change
    add_reference :people, :address, foreign_key: true
  end
end
