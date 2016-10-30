class GolfCoursesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

  def new
	@golf_course = GolfCourse.new
	@golf_course.build_address
  end
  
  def create
      @golf_course = GolfCourse.new(golf_course_params)
      if @golf_course.save
		redirect_to @golf_course
	  else
		render 'new'
	  end
  end
    
  def show
      @golf_course = GolfCourse.find(params[:id])
  end
  
  private
	def golf_course_params
		params.require(:golf_course).permit(:name, :location,
			address_attributes: [:id, :apartmentNumber, :streetNumber, :streetName, :city, :province, :country, :postalCode])
	end
  
end
