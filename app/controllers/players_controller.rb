class PlayersController < ApplicationController
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

  end

  def create
    @player = Player.new(player_params)

    @success = @player.save

    if @success
      redirect_to @player
    else
      render action: "new"
      logger.error "Player was not added to database"
    end

  end

  def update

  end

  def delete
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_path
  end

  private
  def player_params
    params.require(:player).permit(:person_id,:tournament_id)
  end

end
