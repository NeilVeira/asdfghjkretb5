class GolfCourseOrganizersController < ApplicationController
		def index
		@golf_course_organizers = GolfCourseOrganizer.all
    end
    
    def show
    	@golf_course_organizer = GolfCourseOrganizer.find(params[:id])
    end 
    
    def new #display the for new record
    	@golf_course_organizer = GolfCourseOrganizer.new
    end
    
    def create #save new record
    	@golf_course_organizer = GolfCourseOrganizer.new(golf_course_organizer_params)

    	if @golf_course_organizer.save 
    		redirect_to golf_course_organizers_path	
    	else
    		redender 'new' #go back to new if save not successful
    	end
    end
    
    def edit #display form for existing record
    	@golf_course_organizer = GolfCourseOrganizer.find(params[:id])
    end
    
    def update #save changes
    	@golf_course_organizer = GolfCourseOrganizer.find(params[:id])
		@golf_course_organizer.update(golf_course_organizer_params)
		redirect_to @golf_course_organizer
    end
    
    def destroy #destroy record
		@golf_course_organizer = GolfCourseOrganizer.find(params[:id])
		@golf_course_organizer.destroy
		redirect_to golf_course_organizers_path
   	end

    private
		def golf_course_organizer_params
			params.require(:golf_course_organizer).permit(:person, :tournament, :adminrights)
		end
end
