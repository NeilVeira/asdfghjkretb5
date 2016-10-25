class PeopleController < ApplicationController
	before_action :authenticate_user!, only: [:profile, :edit, :update]
	before_action :authenticate_admin!, only: [:index, :show, :destroy]
	
	helper_method :sort_column, :sort_direction

	def index
		@people = Person.all
	end
	
	def new
		@person = Person.new
		@person.build_address
	end
	
	def create
    @user = current_user
    @person = Person.new(person_params)
    @person.user = @user
    if @person.save
        redirect_to '/people/profile'
    else
        render 'new'
    end
	end
	
	def show
    #shows the profile for person with the given id
		@person = Person.find(params[:id])
	end
    
  def profile
    #shows the profile for the current user
		@person = current_person

		#create list of all tournament_ids which the current person is registered for as player
		@players = Player.where("person_id = ?", @person.id)
		@tournament_ids = []
		@players.each do |p|
			@tournament_ids.push(p.tournament.id)
		end
		#get list of tournaments with matching ids and sorted
		@tournaments_as_player = Tournament.where(id: @tournament_ids).order(sort_column + " " + sort_direction)
		
		#do the same for sponsors and organizers
		@tournament_organizers = TournamentOrganizer.where("person_id = ?", @person.id)
		@tournament_ids = []
		@tournament_organizers.each do |to|
			@tournament_ids.push(to.tournament.id)
		end
		@tournaments_as_organizer = Tournament.where(id: @tournament_ids).order(sort_column + " " + sort_direction)
		
		@sponsors = Sponsor.where("person_id = ?", @person.id)
		@tournament_ids = []
		@sponsors.each do |s|
			@tournament_ids.push(s.tournament.id)
		end
		@tournaments_as_sponsor = Tournament.where(id: @tournament_ids).order(sort_column + " " + sort_direction)

        render 'profile'
    end
	
	def edit
		#@person = Person.find(params[:id])
        @user = current_user
        @person = Person.find_by user_id: @user.id
		@person.build_address if @person.address.nil?
>>>>>>> 183582fe6a69e999fc18a1a46e6900950affb579
	end
	
	def update
		@person = current_person
		if @person.update(person_params)
			redirect_to '/people/profile'
		else
			render 'edit'
		end
	end
	
	def destroy
		@person = Person.find(params[:id])
        @person.user.destroy
		@person.destroy
		redirect_to people_path
	end
	
	private

		def person_params
			params.require(:person).permit(:firstname, :lastname, :dob, :phone, :location, :user_id,
				address_attributes: [:id, :apartmentNumber, :streetNumber, :streetName, :city, :province, :country, :postalCode])
		end
	
end

