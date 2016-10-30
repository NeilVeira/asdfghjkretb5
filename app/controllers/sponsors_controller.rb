class SponsorsController < ApplicationController
	before_action :authenticate_user!
	#before_action :authenticate_admin!, only: [:index]

  def index
    @sponsors = Sponsor.all
  end

  def show
    @sponsor = Sponsor.find(params[:id])
  end

  def new
    @sponsor = Sponsor.new
	
	@person = current_person
	@sponsor.person_id = @person.id
	@sponsor.tournament_id = params[:tournament]
	
	@sponsor.save
	
	redirect_to @sponsor
  end

  def edit

  end

  def create
    @sponsor = Sponsor.new(sponsor_params)

	#@sponsor = Sponsor.new()
	
	#@person = current_person
	#@sponsor.person = current_person
	#@tournament = params[:tournament]
	#@sponsor.tournament = Tournament.find_by id: @tournament

    if @sponsor.save
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
