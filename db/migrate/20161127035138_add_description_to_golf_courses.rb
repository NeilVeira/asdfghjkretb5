class AddDescriptionToGolfCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :golf_courses, :description, :string
  end
end
