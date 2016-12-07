class Tournament < ApplicationRecord

	belongs_to :golf_course
	has_many :players
	has_many :teams, dependent: :destroy, inverse_of: :tournament
	has_many :tournament_organizers
	has_many :sponsors

	validates :name, presence: true 
	validates :description, presence: true
	validates :pricePlayer, allow_blank: true, numericality: true
	validates :priceSpectator, allow_blank: true, numericality: true
	validates :priceSponsor, allow_blank: true, numericality: true
	
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
