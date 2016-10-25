module PeopleHelper
  private
  def get_all_sponsors
    @person = current_person
    return Sponsor.where(person_id: @person.id)
  end

  def get_all_players
    @person = current_person
    return Player.where(person_id: @person.id)
  end

  def get_all_tournament_organizers
    @person = current_person
    return TournamentOrganizer.where(person_id: @person.id)
  end

  def get_all_golf_course_organizers
    @person = current_person
    return GolfCourseOrganizer.where(person_id: @person.id)
  end

  def find_tournaments_for (listOfPeople)
    tournamentIds = []

    listOfPeople.each do |person|
      tournamentIds << person.tournament.id
    end

    TournamentList = Tournament.where(id: @tournamentIds) #.order(sort_column + " " + sort_direction)
  end

  def find_golf_courses_for (listOfPeople)
    golfCourseIds = []

    listOfPeople.each do |person|
      golfCourseIds << person.golf_course.id
    end

    return GolfCourse.where(id: @golfCourseIds).order(sort_column + " " + sort_direction)
  end

  public
  # returns tournament objects
  def get_all_tournaments_as (peopleType)
    case peopleType
      when "sponsor"
          return find_tournaments_for (get_all_sponsors)
      when "player"
          return find_tournaments_for (get_all_players)
      when "tournament_organizer", "organizer"
          return find_tournaments_for (get_all_tournament_organizers)
    end
  end

  # returns golf course objects
  def get_all_golf_courses_as (peopleType)
    case peopleType
      when "organizer", "golf_course_organizer"
        return find_golf_courses_for (get_all_golf_course_organizers)
    end
  end
end
