class RemoveTournamentIdFromGolfCourseOrganizers < ActiveRecord::Migration[5.0]
  def change
    remove_column :golf_course_organizers, :tournament_id, :reference
  end
end
