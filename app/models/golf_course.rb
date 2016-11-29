class GolfCourse < ApplicationRecord
	belongs_to :address
    accepts_nested_attributes_for :address
	has_many :golf_course_organizers
	
	has_attached_file :image, default_url: "/images/default_image.jpg"
	
	validates :name, presence: true
	validates :address, presence: true	
	validates :description, presence: true
	validates_attachment :image,
		content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] }
		
	after_validation :cleanup
	
	
	protected
		def cleanup
			self.name = self.name.strip
		end
end
