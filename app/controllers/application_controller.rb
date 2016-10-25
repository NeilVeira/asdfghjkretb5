class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	helper_method :current_person
	
	#Helper methods to get current person or admin objects.
	#They can only be used if the user is signed in
	
	def user_exists?			
		@user = current_user
		if (Person.exists?(user_id: @user))
			return true
		else
			@user.destroy
			return false
		end
	end
	
	def current_person
		@user = current_user
		return Person.find_by user_id: @user.id
	end

	def current_website_admin
		@person = current_person
		return WebsiteAdmin.find_by person_id: @person.id
	end

	def user_is_admin?
		if user_signed_in?
			@website_admin = current_website_admin
			if @website_admin
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def authenticate_admin!
		if user_is_admin?
			return true
		else
			render 'auth_admin'
			return false
		end
	end
	
	def sort_column
		Tournament.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end
	
	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end

end
