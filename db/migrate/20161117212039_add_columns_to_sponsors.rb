class AddColumnsToSponsors < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsors, :name, :string
    add_column :sponsors, :website, :string
    add_column :sponsors, :contact_info, :string
  end
end
