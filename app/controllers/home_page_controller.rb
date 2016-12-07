class HomePageController < ApplicationController
	#require 'rufus-scheduler'

	
	def index
		@scores = Score.all
		@tours = Score.select(:tournament).distinct
		@tour = params[:tour]
		#@total = Team.joins(:tournament, :player)
		#puts @total
	end


end
