class ChangeTypeInAddresses < ActiveRecord::Migration[5.0]
  def self.up
	rename_column :addresses, :type, :addressType
  end
end
