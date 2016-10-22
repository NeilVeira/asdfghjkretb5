class AddGolfCourseToGolfCourseOrganizers < ActiveRecord::Migration[5.0]
  def change
    add_reference :golf_course_organizers, :golf_course, foreign_key: true
  end
end
