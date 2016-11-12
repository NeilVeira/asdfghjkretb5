class Tournament < ApplicationRecord

	belongs_to :golf_course
	has_many :players
	has_many :tournament_organizers
	has_many :sponsors

	validates :name, presence: true 
	validates :description, presence: true
	#validates :pricePlayer, allow_blank: true, format: { with: /\A (\d{1,4}\.\d{2}) {1}\z/}
	#validates :priceSpectator, allow_blank: true, format: { with: /\A (\d{1,4}\.\d{2}) {1}\z/}
	
	validates_inclusion_of :ispublic, :in => [true, false]
	
	# Used for uploading images
	has_attached_file :image, default_url: "/images/default_image.jpg"
	validates_attachment :image,
		content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] }
	
	
	after_validation :cleanup
	
	protected
		def cleanup
			self.name = self.name.strip	
		end
end
