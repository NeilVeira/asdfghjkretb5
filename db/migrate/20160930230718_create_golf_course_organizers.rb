class CreateGolfCourseOrganizers < ActiveRecord::Migration[5.0]
  def change
    create_table :golf_course_organizers do |t|
      t.references :person, foreign_key: true
      t.references :tournament, foreign_key: true
      t.integer :adminrights

      t.timestamps
    end
  end
end
