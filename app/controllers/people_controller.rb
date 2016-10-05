class PeopleController < ApplicationController
    def new
    end
    
    def create
        @person = Person.new(params.require(:person).permit(:firstname, :lastname, :dob, :phone, :email))
        @person.save
        redirect_to @person
        
        #TODO:
        #   - add password
        #   - Verify that all fields are valid
        #   - check that (name,password) key doesn't exist in db already?

    end
    
    def show
        @person = Person.find(params[:id])
    end
end

#Notes:
#   - Currently no index or destroy actions - not needed?
#TODO:
#   - create sign-in and sign-out actions