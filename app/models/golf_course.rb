class GolfCourse < ApplicationRecord
	belongs_to :address
    accepts_nested_attributes_for :address
end
