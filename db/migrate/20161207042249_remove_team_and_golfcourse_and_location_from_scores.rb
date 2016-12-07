class RemoveTeamAndGolfcourseAndLocationFromScores < ActiveRecord::Migration[5.0]
  def change
    remove_column :scores, :team, :string
    remove_column :scores, :golfcourse, :string
    remove_column :scores, :location, :string
  end
end
