class AddImageToTournaments < ActiveRecord::Migration[5.0]
  def change
	add_attachment :tournaments, :image
  end
end
