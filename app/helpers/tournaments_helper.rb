module TournamentsHelper

	def tournament_status(tournament)
		#return registration status of current user for the given tournament object
		#status is NIL if not registered, or tickettype if registered
		status = tournaments_status([tournament])
		if status[tournament.id]
			return status[tournament.id]
		else 
			return NIL
		end
	end

	def user_is_sponsor?(tournament)
		person = current_person
		sponsor = Sponsor.where(person_id: person.id, tournament_id: tournament.id)
		if sponsor.any?
			true
		else
			false
		end
	end

	def user_is_tournament_organizer?(tournament)
		person = current_person
		tournament_organizer = TournamentOrganizer.where(person_id: person.id, tournament_id: tournament.id)
		if tournament_organizer.any?
			true
		else
			false
		end
	end

	def tournaments_status(tournaments)
		#return list of registration statuses of current user for given list of tournaments
		#status is NIL if not registered, or tickettype if registered
		status = Hash.new
		@p = current_person
		tournaments.each do |t|
			logger.debug "tournament: #{t.id}"
			if @p
				ticket = Ticket.find_by_tournament_id_and_person_id(t.id, @p.id)
				if ticket
					status[t.id] = ticket.tickettype
				elsif user_is_admin?
					#admins are automatically organizers for all tournaments
					status[t.id] = 4
				end
			end
		end
		return status
	end

end
