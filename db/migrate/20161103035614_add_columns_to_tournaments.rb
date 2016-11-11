class AddColumnsToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :pricePlayer, :decimal, precision: 6, scale: 2
    add_column :tournaments, :priceSpectator, :decimal, precision: 6, scale: 2
  end
end
