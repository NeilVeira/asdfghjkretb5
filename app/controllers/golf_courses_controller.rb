class GolfCoursesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :authenticate_organizer!, only: [:edit, :update, :destroy] 

	def index
		@golf_course = GolfCourse.all
	end	

	def new
		@golf_course = GolfCourse.new
		@golf_course.build_address
	end

	def create
	  @golf_course = GolfCourse.new(golf_course_params)
	  
	  result = Address.existance(@golf_course.address.streetNumber, @golf_course.address.streetName, @golf_course.address.city, @golf_course.address.province, @golf_course.address.country, @golf_course.address.postalCode)
	  if result != nil
		@golf_course.errors[:base] << "This address already exists!"
		render 'new'
	  elsif @golf_course.save # Also make this person a golf_course_organizer
		GolfCourseOrganizer.create!(person: current_person, adminrights: 1, golf_course: @golf_course)
		redirect_to @golf_course
	  else
		render 'new'
	  end
	end

	def show
		@golf_course = GolfCourse.find(params[:id])	 
	end
  
	def edit
		@user = current_user
		@golf_course = GolfCourse.find(params[:id])
		@golf_course.build_address if @golf_course.address.nil?
	end

	def update
		@golf_course = GolfCourse.find(params[:id])
		if @golf_course.update(golf_course_params)
			redirect_to golf_course_path
		else
			render 'edit'
		end
	end
  
  private
	def golf_course_params
		params.require(:golf_course).permit(:name, :location,
			address_attributes: [:id, :apartmentNumber, :streetNumber, :streetName, :city, :province, :country, :postalCode])
	end
	
	def authenticate_organizer!
		#check that current user is organizer for this golf course
		if not user_is_golf_course_organizer?(params[:id]) and not user_is_admin?
			access_denied
		end		
	end
  
end
