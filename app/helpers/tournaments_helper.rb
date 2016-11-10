module TournamentsHelper

	def user_is_registered?(tournament_id)
		if user_signed_in?
			@person = current_person
			@player = Player.find_by tournament_id: tournament_id, person_id: @person.id
			@tournament_organizer = TournamentOrganizer.find_by tournament_id: tournament_id, person_id: @person.id
			@sponsor = Sponsor.find_by tournament_id: tournament_id, person_id: @person.id
			if @player or @tournament_organizer or @sponsor
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def check_status()
		tournaments = Tournament.all
		status = Hash.new
		person = current_person
		tournaments.each do |t|
			logger.debug "tournament: #{t.id}"
			if Ticket.find_by_tournament_id_and_person_id(t.id, person.id)
				status[t.id] = 1
			end
		end

		return status
	end

end
