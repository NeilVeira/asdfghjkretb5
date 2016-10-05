class AddLocationToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :location, :string
  end
end
