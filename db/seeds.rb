# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users_list = [
    ["1@email.com","password"],
    ["2@email.com","password"],
    ["3@email.com","password"],
    ["4@email.com","password"],
    ["5@email.com","password"],
    ["6@email.com","password"],
    ["7@email.com","password"],
    ["admin1@email.com","password"],
    ["admin2@email.com","password"],
    ["admin3@email.com","password"],
    ["11@email.com","password"],
    ["12@email.com","password"],
    ["13@email.com","password"],
]
users_list.each do |email, password|
    user = User.new
    user.email = email
    user.password = password
    user.password_confirmation = password
    user.save!
end

address_list = [["p",1,40,"Yonge Street","Toronto","Ontario","Canada","M6K 4L2"],
				["p",5,435,"Bloor Street","Toronto","Ontario","Canada","M3H 2V6"],
				["p",7,6342,"Lawrence Avenue","Calgary","Alberta","Canada","H5J 7B2"],
				["p",0,1234,"Lawrence Avenue East","Toronto","Ontario","Canada","M1P 2L9"],
				["p",0,10,"Hogarth Ave","Toronto","Ontario","Canada","M4K 2P3"],
				["p",0,40,"College Street","Toronto","Ontario","Canada","M5G 2J3"],
				["p",0,21,"Calista Street","Woodbridge","Ontario","Canada","L4H 3H8"],
				["p",0,10,"King's College Rd","Toronto","Ontario","Canada","M5S 3G8"],
				["g",24,43,"Fleming Road","Farmingdale","New York","USA","43353533"],
				["g",244,1565,"Carry Road","Scottsdale","Ontario","Canada","R6J 2F6"],
				["g",65,112,"Phone Avenue","RedClock","Utah","USA","94868220"],
				["g", 0, 1000, "Jane Street", "Toronto", "Ontario", "Canada", "M6N 4E2"],
				["g", 0, 4200, "Yonge Street", "Toronto", "Ontario", "Canada", "M2P 1N9"],
				["g", 0, 155, "Saint Dennis Drive", "Toronto", "Ontario", "Canada", "M3C 2S2"],
				["g", 0, 6320, "Grandview Drive West", "University Place", "Washington", "USA", "98467"],
				["g", 0, 1700, "17-Mile Drive", "Pebble Beach", "California", "USA", "93953"],
				["g", 0, 99, "Quaker Meeting House Road", "Farmingdale", "New York", "USA", "11735"],
				["g", 0, 2401, "Biarritz Drive", "Miami Beach", "Florida", "USA", "33141"],
				["g", 0, 1904, "rue Garneau", "Quebec", "Quebec", "Canada", "G1V 3V5"],
				["g", 0, 320, "Front Street West", "Toronto", "Ontario", "Canada", "M5V"],
				]

address_list.each do |addressType, apartmentNumber, streetNumber, streetName, city, province, country, postalCode|
    Address.create(addressType: addressType, apartmentNumber: apartmentNumber, streetNumber: streetNumber, streetName: streetName, city: city, province: province, country: country, postalCode: postalCode)
end

golfcourse_list = [ ["Scarlett Woods Golf Course", 6],
					["Don Valley Golf Course", 7],
					["Flemingdon Park Golf Club", 8],
					["Chambers Bay", 9],
					["Pebble Beach Golf Links", 10],
					["Bethpage Black Course", 11],
					["Normandy Shores Golf Course", 12] ]


golfcourse_list.each do |name,address_id|
	GolfCourse.create(name: name, address_id: address_id)
end

#IMPORTANT: people 8-10 are website admins. To keep data valid, do not use them in other objects (tournaments, players, etc.) 
people_list = [
	["FirstName1", "LastName1", "01-01-1991", "111-111-1111", Address.first.id, User.first.id],
    ["FirstName2", "LastName2", "02-02-1992", "222-222-2222", Address.second.id, User.second.id],
    ["FirstName3", "LastName3", "03-03-1993", "333-333-3333", Address.third.id, User.third.id],
    ["FN4", "LN4", "04-14-1994", "444-444-4444", Address.fourth.id, User.fourth.id],
    ["FN5", "LN5", "05-15-1995", "555-555-5555", Address.fifth.id, User.fifth.id],
    ["FN6", "LN6", "06-26-1996", "666-666-6666", 6, 6],
    ["FN7", "LN7", "10-30-1950", "777-777-7777", 7, 7],
    ["Admin1", "XXX", "01-01-2000", "012-345-6789", 8, 8],
    ["Admin2", "XXX", "01-01-2000", "012-345-6789", 9, 9],
    ["Admin3", "XXX", "01-01-2000", "012-345-6789", 10, 10],
	["FN11", "LN11", "03-13-1953", "555-783-1822", 11, 11],
	["FN12", "LN12", "02-16-1960", "123-321-1232", 19, 12],
	["FN13", "LN13", "03-30-1980", "416-342-1010", 20, 13],
]

people_list.each do |firstname,lastname,dob,phone,address_id,user_id|
	Person.create(firstname: firstname, lastname: lastname, dob: dob, phone: phone, address_id: address_id, user_id: user_id)
end

tournaments_list = [
	["tourname1","description1", true, "extrafeatures1",GolfCourse.first.id, DateTime.new(2016,10,30), "10.00", "20.00" ],
	["tourname2","description2", true, "extrafeatures2",GolfCourse.first.id, DateTime.new(2019,1,1), "0.00", "30.00" ],
	["tourname3","description3", false, "extrafeatures3",GolfCourse.second.id,  DateTime.new(2019,6,8), "4.00", "5.00"],
	["tourname4","description4", true, "extrafeatures4",GolfCourse.second.id,  DateTime.new(2020,12,12), "32.00", "60.00"],
	["tourname5","description5", false, "extrafeatures5",GolfCourse.second.id,  DateTime.new(2019,1,1), "0.00", "0.00"],
	["tourname6","desc6", false, "extraf6",GolfCourse.first.id,  DateTime.new(2019,1,1), "0.00", "5.00"],
	["tourname7","desc7", false, "extraf7",GolfCourse.fourth.id,  DateTime.new(2016,11,30), "0.00", "6.00"]
]

tournaments_list.each do |name, description, ispublic, extrafeatures, golfid, date, price_player, price_spectator|
	Tournament.create(name: name, description: description, ispublic: ispublic, extrafeatures: extrafeatures, golf_course_id: golfid, date: date, price_player: price_player, price_spectator: price_spectator)
end


registered_team_list = [
	["rtname1",Person.first.id,Tournament.first.id],
	["rtname2",Person.second.id,Tournament.first.id],
	["rtname3",Person.third.id,Tournament.third.id],
	["rtname4",Person.fourth.id,Tournament.first.id]
]

registered_team_list.each do |name,  person_id, tournament_id|
	RegisteredTeam.create(name: name, person_id: person_id, tournament_id: tournament_id)
end

website_admins_list = [[8, 0], [9, 1], [10, 2]]

website_admins_list.each do |person_id, adminrights|
	WebsiteAdmin.create(person_id: person_id, adminrights: adminrights)
end

tournament_organizers_list = [
	[Person.first.id,Tournament.first.id, 0],
	[Person.second.id,Tournament.second.id, 1],
	[Person.third.id,Tournament.third.id, 1],
	[Person.fourth.id,Tournament.fourth.id, 0],
	[Person.fifth.id,Tournament.fifth.id, 0],
	[6,6, 0],
	[7,7, 0],
]

tournament_organizers_list.each do | person_id, tournament_id, adminrights|
	TournamentOrganizer.create(person_id: person_id, tournament_id: tournament_id, adminrights: adminrights)
end

golf_course_organizers_list = [
	[Person.first.id,GolfCourse.first.id, 0],
	[Person.second.id,GolfCourse.first.id, 1],
	[Person.third.id,GolfCourse.third.id, 1],
	[Person.fourth.id,GolfCourse.first.id, 0],
	[Person.fifth.id,GolfCourse.fifth.id, 0],
	[6, 6, 2],
	[7, 7, 1],
]

golf_course_organizers_list.each do | person_id, golf_course_id, adminrights|
	GolfCourseOrganizer.create(person_id: person_id, golf_course_id: golf_course_id, adminrights: adminrights)
end

sponsors_list = [
	[Person.first.id,Tournament.fifth.id],
	[Person.third.id,Tournament.first.id],
	[Person.third.id,Tournament.second.id],
	[Person.fourth.id,Tournament.second.id],
	[Person.fifth.id,Tournament.first.id],
]

sponsors_list.each do |person_id, tournament_id|
	Sponsor.create(person_id: person_id, tournament_id: tournament_id)
end

players_list = [
	[Person.first.id,Tournament.first.id],
	[Person.first.id,Tournament.second.id],
	[Person.first.id,Tournament.third.id],
	[Person.first.id,Tournament.fourth.id],
	
	[Person.second.id,Tournament.first.id],
	[Person.second.id,Tournament.second.id],
	[Person.second.id,Tournament.fourth.id],
	
	[Person.third.id,Tournament.first.id],
	[Person.third.id,Tournament.fourth.id],
	[Person.third.id,Tournament.fifth.id],
	[Person.third.id,6],
	
	[Person.fourth.id,Tournament.first.id],
	[Person.fourth.id,Tournament.third.id],
	
	[Person.fifth.id,Tournament.first.id],
	[Person.fifth.id,Tournament.third.id],
	[Person.fifth.id,Tournament.fourth.id],
	
	[6,Tournament.first.id],
	[6,Tournament.second.id],
	[6,Tournament.fourth.id],
	
	[7,Tournament.first.id],
	[7,Tournament.second.id],
	[7,Tournament.fourth.id],
	
	[11,Tournament.first.id],
	[11,Tournament.second.id],
	[11,Tournament.fourth.id],
]

players_list.each do |person_id, tournament_id|
	Player.create(person_id: person_id, tournament_id: tournament_id)
end

#Create a ticket for each player, sponsor, and tournament_organizer 
#ticket types:
#1 - Player
#2 - Sponsor
#3 - Spectator
#4 - Tournament organizer
tickets_list = [[3, 12, Tournament.first.id],
                [3, 13, Tournament.first.id],
				[3, 12, Tournament.second.id],
				[3, 13, Tournament.second.id],
				[3, 6, Tournament.third.id],
				[3, 7, Tournament.third.id],
				[3, 12, Tournament.third.id],
				[3, 13, Tournament.third.id],
				[3, 6, Tournament.fifth.id],
				[3, 7, Tournament.fifth.id],
				[3, 11, Tournament.fifth.id],
				[3, 2, 7],
				[3, 5, 7],
				]
players_list.each do |person_id, tournament_id|
	tickets_list.push([1,person_id,tournament_id])
end
sponsors_list.each do |person_id, tournament_id|
	tickets_list.push([2,person_id,tournament_id])
end
tournament_organizers_list.each do |person_id, tournament_id|
	tickets_list.push([4,person_id,tournament_id])
end
#spectators
tickets_list.push([3])

tickets_list.each do |tickettype, person_id, tournament_id|
	Ticket.create(tickettype: tickettype, person_id: person_id, tournament_id: tournament_id)
end

teams_list = [
	["team1", Tournament.first.id, Player.second.id, 7, Player.fifth.id, 6], 
	["team2", Tournament.first.id, Player.fourth.id, 11, Player.first.id, Player.third.id], 
	["team1", Tournament.second.id, Player.first.id, Player.second.id, 11, 7]
]

teams_list.each do |name, tournamentid, p1, p2, p3, p4|
	Team.create( name: name, tournament_id: tournamentid, p1_id: p1, p2_id: p2, p3_id: p3, p4_id: p4)
end
