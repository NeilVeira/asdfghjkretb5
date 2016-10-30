class WebsiteAdmin < ApplicationRecord
	belongs_to :person
	
	validates :person_id, presence: true
	validates :adminrights, presence: true
end
