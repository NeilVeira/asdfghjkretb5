class RemoveLocationFromPeople < ActiveRecord::Migration[5.0]
  def change
    remove_column :people, :location, :string
  end
end
