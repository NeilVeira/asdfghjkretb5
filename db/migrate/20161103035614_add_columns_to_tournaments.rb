class AddColumnsToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :tournaments, :price_player, :decimal, precision: 6, scale: 2
    add_column :tournaments, :price_spectator, :decimal, precision: 6, scale: 2
  end
end
