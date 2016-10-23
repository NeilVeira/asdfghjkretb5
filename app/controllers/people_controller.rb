class PeopleController < ApplicationController
    before_action :authenticate_user!, only: [:profile, :edit, :update]
	before_action :authenticate_admin!, only: [:index, :show, :destroy]

	def index
		@people = Person.all
	end
	
	def new
        @person = Person.new
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
        #Different view for the current user.
        render 'profile'
    end
	
	def edit
		#@person = Person.find(params[:id])
        @user = current_user
        @person = Person.find_by user_id: @user.id
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
			params.require(:person).permit(:firstname, :lastname, :dob, :phone, :location, :user_id)
		end
	
end

