class PlayersController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin!, only: [:index]

	def index
		@players = Player.all
	end

	def show
		@player = Player.find(params[:id])
	end

	def new
		@player = Player.new
	end

	def edit
		# shouldn't exists.. because can only really register / leave a tournament
	end

	def create
		@player = create_player()
		if @player
			redirect_to @player
		else
			render action: "new"
		end
	end

	def update

	end

	def destroy
		# TODO: should only be allowed by player, current user IS player & tournament organizer?
		@player = Player.find(params[:id])
		@player.destroy
		redirect_to players_path
	end

	private
	def player_params
		params.require(:player).permit(:person_id,:tournament_id)
	end
  


end
