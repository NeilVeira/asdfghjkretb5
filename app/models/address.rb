class Address < ApplicationRecord
    validates :apartmentNumber, presence: true, numericality: { only_integer: true } 
    validates :streetNumber, presence: true, numericality: { only_integer: true } 
    validates :streetName, presence: true 
    validates :city, presence: true 
    validates :province, presence: true 
    validates :country, presence: true 
    validates :postalCode, presence: true 
	
	after_validation :cleanup
	
	protected
		def cleanup
			self.streetName = self.streetName.strip
			self.city = self.city.strip
			self.province = self.province.strip
			self.country = self.country.strip
			self.postalCode = self.postalCode.strip
		end
end
