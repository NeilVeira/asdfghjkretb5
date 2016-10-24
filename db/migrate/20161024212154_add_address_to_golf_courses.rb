class AddAddressToGolfCourses < ActiveRecord::Migration[5.0]
  def change
    add_reference :golf_courses, :address, foreign_key: true
  end
end
