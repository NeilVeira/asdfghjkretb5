class PeopleController < ApplicationController
	before_action :authenticate_user!, only: [:profile, :edit, :update, :user_tourney, :user_tourney_organized, :user_tourney_sponsored :user_ticket]
	before_action :authenticate_admin!, only: [:index, :show]
	before_action :authenticate_admin_or_current_user!, only: [:destroy]
	
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

	def organized
		@person = current_person
		render 'people/user_tourney_organized'
	end

	def sponsored
		@person = current_person
		render 'people/user_tourney_sponsored'
	end

	def user_ticket
		@person = current_person
		render 'people/portal/user_ticket'
	end

	def address
		@person = current_person
    	render 'people/address'
	end

	def linked_services
		@person = current_person
		render 'people/linked_services'
	end

	def payment_information
		@person = current_person
		render 'people/payment_information'
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
		
		TournamentOrganizer.where(person_id: @person.id).delete_all
		Ticket.where(person_id: @person.id).delete_all
		Team.where(p1_id: @person.id).delete_all
		Team.where(p2_id: @person.id).delete_all
		Team.where(p3_id: @person.id).delete_all
		Team.where(p4_id: @person.id).delete_all
		Sponsor.where(person_id: @person.id).delete_all
		Player.where(person_id: @person.id).delete_all
		GolfCourseOrganizer.where(person_id: @person.id).delete_all
		CreditCard.where(person_id: @person.id).delete_all
		
		@user = @person.user
		@address = @person.address
		
		
		@person.destroy
		@address.destroy
		@user.destroy
		
        #@person.user.destroy
		#@person.destroy
		#redirect_to people_path
		
		redirect_to '/'
	end
	
	private

		def person_params
			params.require(:person).permit(:firstname, :lastname, :dob, :phone, :location, :user_id, :image,
				address_attributes: [:id, :apartmentNumber, :streetNumber, :streetName, :city, :province, :country, :postalCode])
		end
	
end

