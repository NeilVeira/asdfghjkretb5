# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
people_list = [
	["FirstName1", "LastName1", "dob1", "phone1","email1","loc1"],["FirstName2", "LastName2", "dob2",  "phone2","email2","loc2"],["FirstName3", "LastName3", "dob3", "address3", "phone3","email3","loc3"],
["FN3", "LN3", "dob3",  "phone3","email3","loc4"],["FN4", "LN4", "dob4",  "phone4","email4","loc5"],["FN5", "LN5", "d5",  "ph5","em5","loc7"],["FN6", "LN6", "d6",  "ph6","em6","loc8"]
]

people_list.each do |firstname,lastname,dob,phone,email,location|
	Person.create(firstname: firstname, lastname: lastname, dob: dob, phone: phone, email: email, location: location)
end

golfcourse_list = [
	["golfn1","loc1"],["golfn2","loc2"],["golfn3","loc3"],["golfn4","loc4"],["golfn5","loc5"],["golfn6","loc6"],["golfn7","loc7"]
]

golfcourse_list.each do |name,location|
	GolfCourse.create(name: name, location: location)
end

tournaments_list = [
	["tourname1","description1", true, "extrafeatures1",GolfCourse.first.id],["tourname2","description2", true, "extrafeatures2",GolfCourse.first.id],["tourname3","description3", true, "extrafeatures3",GolfCourse.second.id],["tourname4","description4", false, "extrafeatures4",GolfCourse.second.id],
	["tourname5","description5", false, "extrafeatures5",GolfCourse.second.id],["tourname6","desc6", false, "extraf6",GolfCourse.first.id]
]

tournaments_list.each do |name, description, ispublic, extrafeatures, golfid|
	Tournament.create(name: name, description: description, ispublic: ispublic, extrafeatures: extrafeatures, golf_course_id: golfid)
end

teams_list = [
	["team1", Tournament.first.id], ["team2", Tournament.first.id], ["team3", Tournament.first.id], ["team4", Tournament.second.id],["team5", Tournament.second.id],["team6", Tournament.fourth.id],["team6", Tournament.fourth.id]
]

teams_list.each do |name, tournamentid|
	Team.create(name: name, tournament_id: tournamentid)
end

tickets_list = [
	[1,Person.first.id],[2,Person.second.id],[3,Person.third.id],[2,Person.fourth.id],[1,Person.fifth.id]
]

tickets_list.each do |tickettype, person_id|
	Ticket.create(tickettype: tickettype,person_id: person_id )
end

registered_team_list = [
	["rtname1",Person.first.id,Tournament.first.id],["rtname2",Person.second.id,Tournament.first.id],["rtname3",Person.third.id,Tournament.third.id],["rtname4",Person.fourth.id,Tournament.first.id]
]

registered_team_list.each do |name,  person_id, tournament_id|
	RegisteredTeam.create(name: name, person_id: person_id, tournament_id: tournament_id)
end

website_admins_list = [
	[ Person.first.id,1], [Person.second.id,0],[Person.third.id,2],[Person.fourth.id,0],[Person.fifth.id,2]
]

website_admins_list.each do |person_id, adminrights|
	WebsiteAdmin.create(person_id: person_id, adminrights: adminrights)
end

tournament_organizers_list = [
	[Person.first.id,Tournament.first.id, 0],[Person.second.id,Tournament.first.id, 1],[Person.third.id,Tournament.third.id, 1],[Person.fourth.id,Tournament.first.id, 0]
]

tournament_organizers_list.each do | person_id, tournament_id, adminrights|
	TournamentOrganizer.create(person_id: person_id, tournament_id: tournament_id, adminrights: adminrights)
end

golf_course_organizers_list = [
	[Person.first.id,Tournament.first.id, 0],[Person.second.id,Tournament.first.id, 1],[Person.third.id,Tournament.third.id, 1],[Person.fourth.id,Tournament.first.id, 0]
]

golf_course_organizers_list.each do | person_id, tournament_id, adminrights|
	GolfCourseOrganizer.create(person_id: person_id, tournament_id: tournament_id, adminrights: adminrights)
end

sponsors_list = [
	[Person.third.id,Tournament.first.id],[Person.fifth.id,Tournament.first.id],[Person.third.id,Tournament.third.id],[Person.fourth.id,Tournament.first.id]
]

sponsors_list.each do |person_id, tournament_id|
	Sponsor.create(person_id: person_id, tournament_id: tournament_id)
end

players_list = [
	[Person.third.id,Tournament.first.id],[Person.fifth.id,Tournament.first.id],[Person.third.id,Tournament.third.id],[Person.fourth.id,Tournament.first.id]
]

players_list.each do |person_id, tournament_id|
	Player.create(person_id: person_id, tournament_id: tournament_id)
end