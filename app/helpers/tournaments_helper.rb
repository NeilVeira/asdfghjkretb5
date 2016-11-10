module TournamentsHelper

	def user_is_registered?(tournament)
		status = check_status([tournament])
		if status[tournament.id]
			return true
		else 
			return false
		end
	end
	
	def check_status(tournaments)
		status = Hash.new
		@p = current_person
		tournaments.each do |t|
			logger.debug "tournament: #{t.id}"
			if @p and Ticket.find_by_tournament_id_and_person_id(t.id, @p.id)
				status[t.id] = 1
			end		
		end
		return status
	end
end
