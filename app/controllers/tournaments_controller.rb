class TournamentsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :authenticate_organizer!, only: [:edit, :update, :destroy, :dashboard]

	def index
		@tournaments = Tournament.order(sort_column + " " + sort_direction)
	end
  
	def new
		@tournament = Tournament.new
		@golfcourses = GolfCourse.all
	end
  
	def create
		@tournament = Tournament.new(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures, :date, :golf_course_id, :price_player, :price_spectator, :image))
		if @tournament.save
			session[:tournament_id] = @tournament.id
			#create ticket for current user as organizer
			@ticket = create_ticket(4)
			if @ticket
				redirect_to ticket_path(@ticket)
			else
				render 'new'
			end
		else
			render 'new'
		end
	end
  
	def show
		@tournament = Tournament.find(params[:id])
		session[:tournament_id] = @tournament.id
	end
	
	def edit
		@tournament = Tournament.find(params[:id])
	end
  
	def update
		@tournament = Tournament.find(params[:id])		
		if @tournament.update(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures, :date, :golf_course_id, :image))		
			redirect_to @tournament
		else
			render 'edit'
		end
	end
	
	def destroy
		@tournament = Tournament.find(params[:id])
		@tournament.destroy
		redirect_to tournaments_path
	end
	
	def dashboard
		@tournament = Tournament.find(params[:id])
		render 'dashboard'
	end
	
	private
	
	def sort_column
		Tournament.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end
	
	def user_is_organizer?
		#check if the current user is an organizer for this tournament
		if user_signed_in?
			@person = current_person
			logger.debug "checking if user is organizer for tournament #{params[:id]}, person #{@person.id}"
			@organizer = TournamentOrganizer.find_by(tournament_id: params[:id], person_id: @person.id)
			if @organizer
				logger.debug "returning true"
				return true
			else
				logger.debug "returning false"
				return false
			end
		else
			return false
		end
	end
	
	def authenticate_organizer!
		#make sure the current user is an organizer for this tournament. If not, display an access denied message and redirect to home
		unless user_is_organizer?
			flash[:notice] = "Access to the requested page is denied due to invalid user credentials"
			redirect_to root_url
		end
	end
	
end
