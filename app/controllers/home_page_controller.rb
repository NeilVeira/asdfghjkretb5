class HomePageController < ApplicationController
	#require 'rufus-scheduler'

	
	def index
		@scores = Score.all
		@tours = Score.where(date: DateTime.now.beginning_of_day..DateTime.now.end_of_day).or( Score.where(date: DateTime.new(1999,9,9))).select(:tournament).distinct
		@tour = params[:tour]
	end


end
