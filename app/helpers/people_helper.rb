module PeopleHelper

  private
  def get_all_sponsors (person)
    Sponsor.where(person_id: person.id)
  end

  def get_all_players (person)
    Player.where(person_id: person.id)
  end

  def get_all_tournament_organizers (person)
    TournamentOrganizer.where(person_id: person.id)
  end

  def get_all_golf_course_organizers (person)
    GolfCourseOrganizer.where(person_id: person.id)
  end

  def get_all_tickets (person)
    Ticket.where(person_id: person.id)
  end

  def find_tournaments_for (listOfPeople)
    @tournamentIds = []

    listOfPeople.each do |person|
      @tournamentIds << person.tournament.id
    end

    Tournament.where(id: @tournamentIds).order(sort_column + " " + sort_direction)
  end

  def find_golf_courses_for (listOfPeople)
    golfCourseIds = []

    listOfPeople.each do |person|
      golfCourseIds << person.golf_course.id
    end

    GolfCourse.where(id: @golfCourseIds).order(sort_column + " " + sort_direction)
  end

  public
  # returns tournament objects
  def get_all_tournaments_as (peopleType, personToFind = current_person) #default arg
    case peopleType
      when "sponsor"
          return find_tournaments_for (get_all_sponsors personToFind)
      when "player"
          return find_tournaments_for (get_all_players personToFind)
      when "tournament_organizer", "organizer"
          return find_tournaments_for (get_all_tournament_organizers personToFind)
    end
  end

  # returns golf course objects
  def get_all_golf_courses_as (peopleType, personToFind = current_person) #default arg
    case peopleType
      when "organizer", "golf_course_organizer"
        return find_golf_courses_for (get_all_golf_course_organizers personToFind)
    end
  end

  def get_user_tickets (personToFind = current_person)
    return get_all_tickets(current_person)
  end

  def check_Tournaments (tournaments)
    c_date = Time.now.to_date
    tournaments_displayed = 0

    tournaments.each do |t|
      t_date = t.date.to_date
      days_away = (t_date - c_date).to_i
    
      if days_away >= 0 
        tournaments_displayed += 1
      end

    end

    if tournaments_displayed >= 1
      return true
    else
      return false
    end

  end
end
