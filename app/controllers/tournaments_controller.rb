class TournamentsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :authenticate_organizer!, only: [:edit, :update, :destroy, :dashboard]

	def index
		@tournaments = Tournament.order(sort_column + " " + sort_direction)
	end
  
	def new
		@tournament = Tournament.new
		@golfcourses = GolfCourse.all
	end
  
	def create
		@tournament = Tournament.new(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures, :date, :golf_course_id, :pricePlayer, :priceSpectator, :priceSponsor, :image))
		if @tournament.save
			session[:tournament_id] = @tournament.id
			#create ticket for current user as organizer
			@ticket = create_ticket(4)
			if @ticket
				#redirect_to ticket_path(@ticket)
				redirect_to tournament_path(@tournament)
			else
				render 'new'
			end
		else
			render 'new'
		end
	end
  
	def show
		@tournament = Tournament.find(params[:id])
		session[:tournament_id] = @tournament.id
		@full_teams = Team.select{|t| t.p1 and t.p2 and t.p3 and t.p4 and t.tournament_id == @tournament.id}.count
		@partial_teams = Team.select{|t| (t.p1 or t.p2 or t.p3 or t.p4) and t.tournament_id == @tournament.id}.count
		
		@person = current_person
		@player = user_is_player?(@tournament.id)
		@to = user_is_organizer?(@tournament.id)
	end
	
	def edit
		@tournament = Tournament.find(params[:id])
	end
  
	def update
		@tournament = Tournament.find(params[:id])		
		if @tournament.update(params.require(:tournament).permit(:name, :description, :ispublic, :extrafeatures, :date, :golf_course_id, :pricePlayer, :priceSpectator, :priceSponsor, :image))		
			#redirect_to @tournament
			redirect_to "/tournaments/#{@tournament.id}/dashboard"
		else
			render 'edit'
		end
	end
	
	def destroy
		@tournament = Tournament.find(params[:id])
		delete_tournament(@tournament)		
		redirect_to tournaments_path
	end
	
	def add_self_to_team
		@tournament = Tournament.find(params[:id])
		@t = Team.find(params[:team])
		@p = Player.find(params[:player])
		
		if(@t.p1.nil?)
			@t.p1 = @p
		elsif(@t.p2.nil?)
			@t.p2 = @p
		elsif(@t.p3.nil?)
			@t.p3 = @p
		elsif(@t.p4.nil?)
			@t.p4 = @p
		else
			redirect_to "/tournaments/#{@tournament.id}", :flash => { :error => 'Attempting to join full team'}
			return
		end
		@t.save(validate: false)
		
		@p.team_id = @t.id
		@p.save
		
		redirect_to "/tournaments/#{@tournament.id}"
	end
	
	def create_new_team
		@tournament = Tournament.find(params[:id])
		if(params[:player] == false)
			redirect_to "/tournaments/#{@tournament.id}", :flash => { :error => 'You were not found to be a player.'}
			return
		else
			@p = Player.find(params[:player])
			@current_teams = @tournament.teams
			
			if(@current_teams.empty?)
				new_team_num = 1
			else
				new_team_num = @current_teams.last.team_num + 1
			end
			
			
			@t = Team.new(:tournament => @tournament, :team_num => new_team_num)
			@t.p1 = @p
			@t.save(validate: false)
			
			@p.team = @t
			@p.save
		end
		
		redirect_to "/tournaments/#{@tournament.id}"
	end
	
	def dashboard
		@tournament = Tournament.find(params[:id])
		session[:tournament_id] = @tournament.id #just in case the user goes to this path without first going through the tournament#show
		@person = current_person
		@organizer = TournamentOrganizer.find_by(tournament_id: params[:id], person_id: @person.id)
		@is_admin = user_is_admin?
		
		@full_teams = Team.select{|t| t.p1 and t.p2 and t.p3 and t.p4 and t.tournament_id == @tournament.id}.count
		
		render 'dashboard'
	end
	
	def create_new_teams_for_tournament
		@tournament = Tournament.find(params[:id])
		teams_needed = (@tournament.players.select{|p| p.team_id == nil }.length / 4.to_f).ceil
		full_teams = Team.select{|t| t.p1 and t.p2 and t.p3 and t.p4 and t.tournament_id == @tournament.id}.count
		t_s_input = params.require(:teams_selected).permit!.values.collect{ |i| i.to_i}
		t_s_player_id = params.require(:teams_selected).permit!.to_a.collect{ |k, v| k.to_i}
		
		for i in full_teams+1..full_teams+teams_needed
			@team_i = Team.where(:team_num => i, :tournament_id => params[:id]).first
			
			if (@team_i.blank? and t_s_input.count(i) > 4 )
				redirect_to "/tournaments/#{@tournament.id}/dashboard", :flash => { :error => 'Too many players to add.'}
				return
			elsif ( @team_i.blank? == false and (4 - @team_i.player.size) < t_s_input.count(i) )
				debug
				redirect_to "/tournaments/#{@tournament.id}/dashboard", :flash => { :error => 'Too many players to add.'}
				return
			end
		end
		
		for i in full_teams+1..full_teams+teams_needed
			@team_i = Team.where(:team_num => i, :tournament_id => params[:id]).first
			indexes_needed = t_s_input.each_index.select{|j| t_s_input[j] == i}
			
			if(@team_i.blank?)
				@team = Team.new(:tournament_id => @tournament.id, :team_num => i)
				@team.save(validate: false)
				
				if (indexes_needed.count == 4)
					Player.find(t_s_player_id[indexes_needed[3]]).update(team_id: @team.id)
					@team.p4_id = t_s_player_id[indexes_needed[3]]
				end
				if(indexes_needed.count >= 3)
					Player.find(t_s_player_id[indexes_needed[2]]).update(team_id: @team.id)
					@team.p3_id = t_s_player_id[indexes_needed[2]]
				end
				if(indexes_needed.count >= 2)
					Player.find(t_s_player_id[indexes_needed[1]]).update(team_id: @team.id)
					@team.p2_id = t_s_player_id[indexes_needed[1]]
				end
				Player.find(t_s_player_id[indexes_needed[0]]).update(team_id: @team.id)
				@team.p1_id = t_s_player_id[indexes_needed[0]]
				
				@team.save(validate: false)
			else
				if(@team_i.p1_id == nil)
					@team_i.p1_id = t_s_player_id[indexes_needed[0]]
					Player.find(t_s_player_id[indexes_needed[0]]).update(team_id: @team_i.id)
				end
				if(@team_i.p2_id == nil)
					@team_i.p1_id = t_s_player_id[indexes_needed[1]]
					Player.find(t_s_player_id[indexes_needed[1]]).update(team_id: @team_i.id)
				end
				if(@team_i.p3_id == nil)
					@team_i.p1_id = t_s_player_id[indexes_needed[2]]
					Player.find(t_s_player_id[indexes_needed[2]]).update(team_id: @team_i.id)
				end
				if(@team_i.p4_id == nil)
					@team_i.p1_id = t_s_player_id[indexes_needed[3]]
					Player.find(t_s_player_id[indexes_needed[3]]).update(team_id: @team_i.id)
				end
				
				@team_i.save(validate: false)
			end
		end
		
		redirect_to "/tournaments/#{@tournament.id}/dashboard"
		return
	end
	
		def view_players
		players_in_tourney = Player.where(tournament: params[:id]).pluck(:person_id)
		logger.info "#{@players_in_tourney}"
		
		@tournament = params[:id]
		
		@players = Array.new();
		players_in_tourney.each do |p|
			@temp = Person.find(p)
			@players.push(@temp)
		end
	end
	
	def view_sponsors
		sponsors_in_tourney = Sponsor.where(tournament: params[:id]).pluck(:person_id)
		logger.info "#{@players_in_tourney}"
		
		@tournament = params[:id]
		
		@sponsors = Array.new();
		sponsors_in_tourney.each do |p|
			@temp = Person.find(p)
			@sponsors.push(@temp)
		end
	end
	
	def view_tournament_organizers
		tos_in_tourney = TournamentOrganizer.where(tournament: params[:id]).pluck(:person_id)
		logger.info "#{@players_in_tourney}"
		
		@tournament = params[:id]
		
		@tos = Array.new();
		tos_in_tourney.each do |p|
			@temp = Person.find(p)
			@tos.push(@temp)
		end
	end
	
	private
	
	def authenticate_organizer!
		#make sure the current user is an organizer for this tournament. If not, display an access denied message and redirect to home
		unless user_is_organizer?(params[:id])
			access_denied
		end
	end
	
end
