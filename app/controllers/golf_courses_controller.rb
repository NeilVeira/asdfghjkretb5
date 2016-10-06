class GolfCoursesController < ApplicationController
  def new
  end
  
  def create
      @golf_course = GolfCourse.new(params.require(:golf_course).permit(:name, :location))
      @golf_course.save
      redirect_to @golf_course
  end
    
  def show
      @golf_course = GolfCourse.find(params[:id])
  end
  
end
