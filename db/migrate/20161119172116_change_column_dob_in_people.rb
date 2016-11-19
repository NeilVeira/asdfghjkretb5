class ChangeColumnDobInPeople < ActiveRecord::Migration[5.0]
  def change
	change_column :people, :dob, :date
  end
end
