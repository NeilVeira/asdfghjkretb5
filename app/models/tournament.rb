class Tournament < ApplicationRecord

	belongs_to :golf_course
	has_many :players

	validates :name, presence: true 
	validates :description, presence: true
	validates :price, allow_blank: true, format: { with: /\A (\d{1,4}\.\d{2}) {1}\z/}
	
	validates_inclusion_of :ispublic, :in => [true, false]
	
	after_validation :cleanup
	
	protected
		def cleanup
			self.name = self.name.strip	
		end
end
