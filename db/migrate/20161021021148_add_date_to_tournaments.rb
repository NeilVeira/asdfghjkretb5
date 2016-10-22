class AddDateToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :date, :datetime
  end
end
