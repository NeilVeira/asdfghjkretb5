class Person < ApplicationRecord
    belongs_to :user
	belongs_to :address
    accepts_nested_attributes_for :address
	validates :firstname, presence: true 
	validates :lastname, presence: true
	validates :dob, presence: true, format: { with: /\A(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])-((19[2-9][0-9])|(2000))\z/,
		message: "Invalid date of birth"}
	validates :phone, presence: true, format: { with: /\A\d\d\d-\d\d\d-\d\d\d\d\z/,
		message: "Invalid phone number"}
	validates :location, presence: true
	validates :user, presence: true
	
	after_validation :cleanup
	
	protected
		def cleanup
			self.firstname = self.firstname.strip
			self.lastname = self.lastname.strip			
		end
end
