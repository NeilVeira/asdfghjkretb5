class PeopleController < ApplicationController
	def index
		@people = Person.all
	end
	
	def new
	end
	
	def create
		@person = Person.new(person_params)
		@person.save
		redirect_to @person
	end
	
	def show
		@person = Person.find(params[:id])
	end
	
	def edit
		@person = Person.find(params[:id])
	end
	
	def update
		@person = Person.find(params[:id])
		@person.update(person_params)
		redirect_to @person
	end
	
	def destroy
		@person = Person.find(params[:id])
		@person.destroy
		redirect_to people_path
	end
	
	private
		def person_params
			params.require(:person).permit(:firstname, :lastname, :dob, :phone, :location, :email)
		end
	
end

