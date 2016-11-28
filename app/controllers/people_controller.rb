class PeopleController < ApplicationController
	before_action :authenticate_user!, only: [:profile, :edit, :update, :user_tourney, :user_ticket]
	before_action :authenticate_admin!, only: [:index, :show, :destroy]
	
	helper_method :sort_column, :sort_direction

	def index
		@people = Person.all
	end
	
	def new
		@person = Person.new
		data = session["data"]
		if data
			@person.firstname = data[0]
			@person.lastname = data[1]
		end
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
		@golf_courses = []
        GolfCourseOrganizer.where(person: @person).find_each do |p|
			@golf_courses << p.golf_course
        end		
	end

	def portal
	#Portal holds links to all user actions they can do once they sign in 
		@person = current_person
		render 'people/portal/portal'
	end 
    
    def profile
    #shows the profile for the current user
		@person = current_person

		render 'profile'
    end

    def user_tourney
    #Show tournaments that the user is participating in
    	@person = current_person
    	render 'people/portal/user_tourney'
    end

    def user_ticket
    	@person = current_person
    	render 'people/portal/user_ticket'
    end
	
	def edit
		#@person = Person.find(params[:id])
        @user = current_user
        @person = Person.find_by user_id: @user.id
				@person.build_address if @person.address.nil?
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
			params.require(:person).permit(:firstname, :lastname, :dob, :phone, :location, :user_id, :image,
				address_attributes: [:id, :apartmentNumber, :streetNumber, :streetName, :city, :province, :country, :postalCode])
		end
	
end

