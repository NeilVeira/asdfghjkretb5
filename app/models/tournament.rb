class Tournament < ApplicationRecord

	belongs_to :golf_course

	validates :name, presence: true 
	validates :description, presence: true
	
	validates_inclusion_of :ispublic, :in => [true, false]
	after_validation :cleanup
	
	protected
		def cleanup
			self.name = self.name.strip	
		end
end
