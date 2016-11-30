class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	helper_method :current_person, :sort_column, :sort_direction, :user_is_admin?, :user_is_golf_course_organizer?, :user_matches_param?
	before_action :set_locale
	#Helper methods to get current person or admin objects.
	#They can only be used if the user is signed in

	def set_locale
		 locale = params[:locale].to_s.strip.to_sym
    	 I18n.locale = I18n.available_locales.include?(locale) ?
        		locale :
        		I18n.default_locale
	end
	
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
		if user_signed_in?
			@user = current_user
			return Person.find_by user_id: @user.id
		else
			return NIL
		end
	end

	def current_website_admin
		@person = current_person
		if @person
			return WebsiteAdmin.find_by person_id: @person.id
		else
			return NIL
		end
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
	
	def user_is_organizer?(tournament_id)
		#check if the current user is an organizer for this tournament
		if user_is_admin?
			return true
		elsif user_signed_in?
			@person = current_person
			@organizer = TournamentOrganizer.find_by(tournament_id: tournament_id, person_id: @person.id)
			if @organizer
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def user_is_golf_course_organizer?(golf_course)
		if user_is_admin?
			return true
		elsif user_signed_in?
			@person = current_person
			@organizer = GolfCourseOrganizer.find_by(golf_course: golf_course, person: @person)
			if @organizer
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
			access_denied
		end
	end
	
	def authenticate_admin_or_current_user!
		unless current_person.id == params[:id].to_i
			authenticate_admin!
		end
	end
	
	def sort_column
		Tournament.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
	
	#helper methods to create objects. These are called from other controller
	#methods because Rails doesn't allow you to redirect_to post method
	
	def create_player
		@player = Player.new()
		@player.person = current_person
		@player.tournament = Tournament.find(session[:tournament_id])
		if @player.save
			logger.debug "Player created successfully"
			return @player
		else
			logger.error "Player was not added to database"
		end
	end
	
	def create_organizer
		@organizer = TournamentOrganizer.new()
		@organizer.person = current_person
		@organizer.tournament = Tournament.find(session[:tournament_id])
		@organizer.adminrights = 1023 #represents full privileges
		if @organizer.save
			logger.debug "Organizer created successfully"
			return @organizer
		else
			logger.error "Organizer was not added to database"
		end
	end
	
	def create_ticket(tickettype)
		ticket = Ticket.new()
		ticket.person = current_person
		tournament = Tournament.find(session[:tournament_id])
		ticket.tournament = tournament
		ticket.tickettype = tickettype
		logger.debug "ticket.tickettype = #{ticket.tickettype}"
		
		if ticket.save
			logger.debug "Ticket created successfully"
			#create player, sponsor, or organizer depending on tickettype
			case ticket.tickettype
				when 1
					logger.debug "creating player object"
					@player = create_player()
				when 2
					#sponsor will be created later
					#@sponsor = create_sponsor()
				when 4
					logger.debug "creating organizer object"
					@organizer = create_organizer()
			end
			return ticket
		else
			ticket_exists = Ticket.where(person_id: current_person.id, tournament_id: tournament.id)
			logger.error "Ticket was not added to database"
			if ticket_exists.any?
				logger.error "Ticket: #{ticket_exists.id}"
			end
		end
	end
	
	def access_denied
		flash[:notice] = "Access to the requested page is denied"
		redirect_to root_url
	end


	private
	
	def delete_tournament(tournament)
		#delete tournament and all tournament_organizers, players, teams, sponsors, and tickets associated with it
		Player.where(tournament: tournament).find_each do |x|
			x.destroy
		end
		Sponsor.where(tournament: tournament).find_each do |x|
			x.destroy
		end
		TournamentOrganizer.where(tournament: tournament).find_each do |x|
			x.destroy
		end
		Team.where(tournament: tournament).find_each do |x|
			x.destroy
		end
		Ticket.where(tournament: tournament).find_each do |x|
			x.destroy
		end
		
		tournament.destroy
	end

end	
