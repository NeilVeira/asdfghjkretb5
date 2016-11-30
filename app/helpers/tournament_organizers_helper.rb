module TournamentOrganizersHelper

  def is_current_tournament_organizer? (t_id = session[:tournament_id])
    if TournamentOrganizer.where(tournament_id: t_id, person_id: current_person.id).any?
      return true
    else
      return false
    end
  end
end
