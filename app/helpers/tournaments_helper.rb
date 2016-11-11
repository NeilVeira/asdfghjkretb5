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
				end
			end
		end
		return status
	end

end
