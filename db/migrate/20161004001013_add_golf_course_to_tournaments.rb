class AddGolfCourseToTournaments < ActiveRecord::Migration[5.0]
  def change
    add_reference :tournaments, :golf_course, foreign_key: true
  end
end
