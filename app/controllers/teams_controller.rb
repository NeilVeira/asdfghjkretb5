class TeamsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	#TODO: require that user is organizer for current tournament

	def index
		@teams = Team.all
	end

	def show 
		@team = Team.find(params[:id])
	end

	def new 
		@team = Team.new
	end

	def edit
		@team = Team.find(params[:id])

	end

	def create
		@team = Team.new(team_params)
		@team.save
		redirect_to @team
	end

	def update
		@team = Team.find(params[:id])
		@team.update(team_params)
		redirect_to @team
	end

	def destroy 
		@team = Team.find(params[:id])
		@team.destroy
		redirect_to teams_path
	end

   private 
	def team_params
		params.require(:team).permit(:name, :tournament_id)
	end 
end
