class Tournament < ApplicationRecord
	validates :name, presence: true 
	validates :description, presence: true
	
	validates_inclusion_of :ispublic, :in => [true, false]
	after_validation :cleanup
	
	protected
		def cleanup
			self.name = self.name.strip	
		end
end
