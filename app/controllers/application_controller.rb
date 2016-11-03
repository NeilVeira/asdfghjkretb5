class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	helper_method :current_person, :sort_column, :sort_direction, :user_is_admin?
	
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
		unless user_is_admin?
			flash[:notice] = "Access to the requested page is denied due to invalid user credentials"
			redirect_to root_url
		end
	end
	
	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
	
	def create_player
		@player = Player.new()
		@player.person = current_person
		@player.tournament = Tournament.find(session[:tournament_id])
		if @player.save
			logger.debug "Player created successfully"
			return true
		else
			logger.error "Player was not added to database"
			return false
		end
	end

end
