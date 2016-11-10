module TournamentsHelper

	def user_is_registered?(tournament)
		status = check_status()
		if status[tournament.id]
			return true
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
