class Sponsor < ApplicationRecord
	belongs_to :person
	belongs_to :tournament
	
	validates :person_id, presence: true
	validates :tournament_id, presence: true
	validates :name, presence: true
	validates :website, presence: true, format: { with: /\A\w+\.\w+\z/, message: "Invalid website"}
	validates :contact_info, presence: true 
	
	has_attached_file :logo, default_url: "/images/default_logo.gif"
	validates_attachment :logo,
		content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] }
end
