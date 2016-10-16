class GolfCourseOrganizer < ApplicationRecord
  belongs_to :person
  belongs_to :golf_course
end
