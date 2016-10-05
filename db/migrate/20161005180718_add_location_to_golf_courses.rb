class AddLocationToGolfCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :golf_courses, :location, :string
  end
end
