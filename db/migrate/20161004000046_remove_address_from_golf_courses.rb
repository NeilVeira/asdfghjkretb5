class RemoveAddressFromGolfCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :golf_courses, :address, :string
  end
end
