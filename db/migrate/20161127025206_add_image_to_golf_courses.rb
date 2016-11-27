class AddImageToGolfCourses < ActiveRecord::Migration[5.0]
  def self.up
    change_table :golf_courses do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :golf_courses, :image
  end
end
