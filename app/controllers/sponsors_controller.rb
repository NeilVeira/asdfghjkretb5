class SponsorsController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin!, only: [:index]

  def index
    @sponsors = Sponsor.all
  end

  def show
    @sponsor = Sponsor.find(params[:id])
  end

  def new
    @sponsor = Sponsor.new
  end

  def edit

  end

  def create
    @sponsor = Sponsor.new(sponsor_params)

    @success = @sponsor.save

    if @success
      redirect_to @sponsor
    else
      render action: "new"
      logger.error "Sponsor was not added to database"
    end

  end

  def update

  end

  def delete
    @sponsor = Sponsor.find(params[:id])
    @sponsor.destroy
    redirect_to sponsors_path
  end

  private
  def sponsor_params
    params.require(:sponsors).permit(:person_id,:tournament_id)
  end

end
