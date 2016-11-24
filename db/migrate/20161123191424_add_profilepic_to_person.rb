class AddProfilepicToPerson < ActiveRecord::Migration[5.0]
  def change
	add_attachment :people, :image
  end
end
