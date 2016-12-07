class HomePageController < ApplicationController
	#require 'rufus-scheduler'

	
	def index
		@scores = Score.all
		@tours = Score.select(:tournament, :location).distinct
		@tour = params[:tour]
		#@displaytour = params[tour]
		#@players = Score.where(:tournament: @displaytour)
		#ENV['TZ'] = 'America/New_York'
		#scheduler = Rufus::Scheduler.new

		#scheduler.in '6s' do
		#updatescore()
		#end

		#scheduler.join
	end


end
