class RemoveTournamentFromGolfCourseOrganizers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :golf_course_organizers, :tournament, foreign_key: true
  end
end
