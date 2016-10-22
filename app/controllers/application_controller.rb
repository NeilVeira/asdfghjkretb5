class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	
	#Helper methods to get current person or admin objects.
	#They can only be used if the user is signed in
	def current_person
		@user = current_user
		return Person.find_by user_id: @user.id
	end
	
	def current_admin
		@person = current_person
		return WebsiteAdmin.find_by person_id: @person.id
	return
  
end
