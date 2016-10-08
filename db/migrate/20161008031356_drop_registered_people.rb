class DropRegisteredPeople < ActiveRecord::Migration[5.0]
  def change
		drop_table :registered_people
  end
end
