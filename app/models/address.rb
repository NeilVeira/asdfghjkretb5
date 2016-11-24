class Address < ApplicationRecord
    #validates :apartmentNumber, allow_blank: true, numericality: { only_integer: true }
    validates :streetNumber, presence: true, numericality: { only_integer: true } 
    validates :streetName, presence: true 
    validates :city, presence: true 
    validates :province, presence: true 
    validates :country, presence: true 
    validates :postalCode, presence: true 
	
	before_validation :cleanup
	
	def self.existance(t_streetNumber, t_streetName, t_city, t_province, t_country, t_postalCode)
		return Address.find_by streetNumber: t_streetNumber, streetName: t_streetName, city: t_city, province: t_province, country: t_country, postalCode: t_postalCode
	end
	
	protected
		def cleanup
			self.streetName = self.streetName.strip
			self.city = self.city.strip
			self.province = self.province.strip
			self.country = self.country.strip
			self.postalCode = self.postalCode.strip
		end
end
