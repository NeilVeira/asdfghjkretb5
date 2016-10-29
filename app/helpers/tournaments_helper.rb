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
end
