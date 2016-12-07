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
		@sponsor = Sponsor.new()
		@tournament = Tournament.find(session[:tournament_id])
		#@sponsor.tournament = Tournament.find(session[:tournament_id])
	end

	def edit
		
	end

	def create
		@sponsor = Sponsor.new(sponsor_params)
		@sponsor.person = current_person
		@tournament = Tournament.find(session[:tournament_id])
		@sponsor.tournament = @tournament
		if @sponsor.save
			logger.debug "Sponsor created successfully"
			#find the ticket which should have previously been created for this sponsor
			@ticket = Ticket.find_by(tournament_id: @sponsor.tournament.id, person_id: @sponsor.person.id)
			if @tournament.priceSponsor != NIL and @tournament.priceSponsor > 0
				redirect_to payment_path(@ticket)
			else
				redirect_to @ticket
			end
		else
			logger.error "Sponsor was not added to database"
			render 'new'
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
		params.require(:sponsors).permit(:name, :website, :contact_info, :logo)
	end

end
