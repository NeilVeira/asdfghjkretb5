class UpdateProvidersInUsers < ActiveRecord::Migration[5.0]
  def change
	rename_column :users, :provider, :fb_provider
	add_column :users, :in_provider, :string
  end
end
