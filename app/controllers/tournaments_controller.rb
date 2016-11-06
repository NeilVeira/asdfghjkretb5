class TournamentsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	#TODO: edit, update, and destroy actions should require more than logging in - user
	#should be the organizer for the current tournament

	def index
		@tournaments = Tournament.order(sort_column + " " + sort_direction)
		@status = check_status(@tournaments)
	end
  
	def new
		@tournament = Tournament.new
		@golfcourses = GolfCourse.all
	end
  
	def create
		@tournament = Tournament.new(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures, :date, :golf_course_id))
		if @tournament.save
			redirect_to @tournament
		else
			render 'new'
		end
	end
  
	def show
		@tournament = Tournament.find(params[:id])
		session[:tournament_id] = @tournament.id
		#@tournament.date = Date.new(2017,2,3)  # Note: this line should be destroyed later, but I need it for testing. - Anthony
	end
	
	def edit
		@tournament = Tournament.find(params[:id])
	end
  
	def update
		@tournament = Tournament.find(params[:id])		
		if @tournament.update(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures, :date, :golf_course_id))		
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
	
	private
	
	def sort_column
		Tournament.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end
	
	def check_status(tournaments)
		status = Hash.new
		@p = current_person
		tournaments.each do |t|
			logger.debug "tournament: #{t.id}"
			if Ticket.find_by_tournament_id_and_person_id(t.id, @p.id)
				status[t.id] = 1
			end		
		end
		
		return status
	end
end
