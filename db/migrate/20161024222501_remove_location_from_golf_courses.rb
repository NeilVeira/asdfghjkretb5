class RemoveLocationFromGolfCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :golf_courses, :location, :string
  end
end
