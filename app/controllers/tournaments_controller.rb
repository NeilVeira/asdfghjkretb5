class TournamentsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	#TODO: edit, update, and destroy actions should require more than logging in - user
	#should be the organizer for the current tournament

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
	
	private
	
	def sort_column
		Tournament.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end

end
