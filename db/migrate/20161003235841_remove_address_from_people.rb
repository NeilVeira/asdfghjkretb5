class RemoveAddressFromPeople < ActiveRecord::Migration[5.0]
  def change
    remove_column :people, :address, :string
  end
end
