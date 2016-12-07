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
    ["14@email.com","password"],
    ["15@email.com","password"],
    ["16@email.com","password"],
    ["17@email.com","password"],
    ["18@email.com","password"],
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
				["p",0,1000,"Jane Street","York","Ontario","Canada","M6N 4E2"],
				["p",0,4200,"Yonge Street","North York","Ontario","Canada","M2P 1N9"], 
				["p",0,155,"St Dennis Dr","North York","Ontario","Canada","M3C 2S2"],
				["g",0,6320,"Grandview Dr W","University Place","Washington State","USA","98467"],
				["g",0,1700,"17-Mile Drive","Pebble Beach","California","USA","93953"],
				["g",0,99,"Quaker Meeting House Rd","Farmingdale","New York","USA","11735"],
				["g", 0, 2401, "Biarritz Dr", "Miami Beach", "Florida", "USA", "33141"],
				["g", 0, 4200, "Yonge Street", "Toronto", "Ontario", "Canada", "M2P 1N9"],
				["g", 0, 155, "Saint Dennis Drive", "Toronto", "Ontario", "Canada", "M3C 2S2"],
				["g", 0, 6320, "Grandview Drive West", "University Place", "Washington", "USA", "98467"],
				["g", 0, 1700, "17-Mile Drive", "Pebble Beach", "California", "USA", "93953"],
				["g", 0, 99, "Quaker Meeting House Road", "Farmingdale", "New York", "USA", "11735"],
				["g", 0, 2401, "Biarritz Drive", "Miami Beach", "Florida", "USA", "33141"],
				["g", 0, 1904, "rue Garneau", "Quebec", "Quebec", "Canada", "G1V 3V5"],
				["g", 0, 320, "Front Street West", "Toronto", "Ontario", "Canada", "M5V"],
				["g", 0, 2861, "Weston rd", "Toronto", "Ontario", "Canada", "M9N 1G4"],
				["g", 0, 4133, "Port Washington Road", "Granum", "Alberta", "Canada", "T0L 1A0"],
				["g", 0, 2754, "Velvet Elk Nook", "Vopolo Havoka", "British Columbia", "Canada", "V1M 6D1"],
				["g", 0, 9260, "Foggy Private", "Starbuck", "Yukon", "Canada", "Y2S 1I8"],
				]

address_list.each do |addressType, apartmentNumber, streetNumber, streetName, city, province, country, postalCode|
    Address.create(addressType: addressType, apartmentNumber: apartmentNumber, streetNumber: streetNumber, streetName: streetName, city: city, province: province, country: country, postalCode: postalCode)
end

golfcourse_list = [ ["Scarlett Woods Golf Course", 6, "public/images/golf_courses/scarlett_woods.jpg", "Scarlett Woods Golf Course is an executive-length par 62 course suitable for beginners and experts alike."],
					["Don Valley Golf Course", 7, "public/images/golf_courses/don_valley.jpg", "Don Valley features lush vegetation and a rolling landscape. Its offers a traditional variety of holes and has a legendary reputation for its exciting natural setting. Hallelujah Corner includes the signature Par 5 12th hole followed by an outstanding par 3 challenge."],
					["Flemingdon Park Golf Club", 8, "public/images/golf_courses/flemingdon_park.jpg", "A picturesque 9-hole golf course in the valley of the don just minutes away from downtown Toronto. Established in the early 1960s the course has been home to many of the locals and intermediate players."],
					["Chambers Bay", 9, "public/images/golf_courses/chambers_bay.jpg", "Chambers Bay brings traditions of Scottish linksland to the Pacific Northwest. Adventure through towering dunes, massive fairways, and breathtaking views."],
					["Pebble Beach Golf Links", 10, "public/images/golf_courses/pebble_beach.jpg", "The legendary Pebble Beach Resorts, between Monterey and Carmel, CA, features four renowned Monterey golf courses and three acclaimed resorts."],
					["Bethpage Black Course", 11, "public/images/golf_courses/bethpage_black.jpg", "The Bethpage Black Course is a public golf course on Long Island, New York, the most difficult of the five courses at Bethpage State Park."],
					["Normandy Shores Golf Course", 12, "public/images/golf_courses/normandy_shores.jpg", "Normandy Shores Golf Club located at the northern end of Miami Beach on a secluded island in Biscayne Bay is enjoyable for both the novice and pro."] ]


golfcourse_list.each do |name,address_id,image, description|
	#TODO: how to create image parameters?
	GolfCourse.create(name: name, address_id: address_id, image: File.new(image), description: description)
end

#IMPORTANT: people 8-10 are website admins. To keep data valid, do not use them in other objects (tournaments, players, etc.) 
people_list = [
	["FirstName1", "LastName1", Date.new(1991,1,1), "111-111-1111", Address.first.id, User.first.id],
    ["FirstName2", "LastName2", Date.new(1992,2,2), "222-222-2222", Address.second.id, User.second.id],
    ["FirstName3", "LastName3", Date.new(1993,3,3), "333-333-3333", Address.third.id, User.third.id],
    ["FN4", "LN4", Date.new(1994,4,14), "444-444-4444", Address.fourth.id, User.fourth.id],
    ["FN5", "LN5", Date.new(1995,5,15), "555-555-5555", Address.fifth.id, User.fifth.id],
    ["FN6", "LN6", Date.new(1996,6,26), "666-666-6666", 6, 6],
    ["FN7", "LN7", Date.new(1950,10,30), "777-777-7777", 7, 7],
    ["Admin1", "XXX", Date.new(2000,1,1), "012-345-6789", 8, 8],
    ["Admin2", "XXX", Date.new(2000,1,1), "012-345-6789", 9, 9],
    ["Admin3", "XXX", Date.new(2000,1,1), "012-345-6789", 10, 10],
	["FN11", "LN11", Date.new(1953,3,13), "555-783-1822", 11, 11],
	["FN12", "LN12", Date.new(1960,2,16), "123-321-1232", 19, 12],
	["FN13", "LN13", Date.new(1980,3,30), "416-342-1010", 20, 13],
	["FN14", "LN14", Date.new(1990,1,12), "416-000-1111", 21, 14],
	["FN15", "LN15", Date.new(1955,11,12), "123-340-9432", 12, 15], #extra person which is not registered for any tournaments in any way (for testing)
	["FN16", "LN16", Date.new(1932,5,5), "543-123-8497", 22, 16], 
	["FN17", "LN17", Date.new(1999,5,7), "239-487-1002", 23, 17], 
	["FN18", "LN18", Date.new(1932,4,16), "019-834-5619", 24, 18], 
]

people_list.each do |firstname,lastname,dob,phone,address_id,user_id|
	Person.create(firstname: firstname, lastname: lastname, dob: dob, phone: phone, address_id: address_id, user_id: user_id)
end

tournaments_list = [
	["tourname1","description1", true, "extrafeatures1",GolfCourse.first.id, DateTime.now, "10.00", "20.00", "500.00" ],
	["tourname2","description2", true, "extrafeatures2",GolfCourse.first.id, DateTime.new(2019,1,1), "0.00", "30.00", "600.00" ],
	["tourname3","description3", false, "extrafeatures3",GolfCourse.second.id,  DateTime.new(2019,6,8), "4.00", "5.00", "200.00"],
	["tourname4","description4", true, "extrafeatures4",GolfCourse.second.id,  DateTime.new(2020,12,12), "32.00", "60.00", "1000.00"],
	["tourname5","description5", false, "extrafeatures5",GolfCourse.second.id,  DateTime.new(2019,1,1), "0.00", "0.00", "100.00"],
	["tourname6","desc6", true, "extraf6",GolfCourse.first.id,  DateTime.new(2019,1,1), "0.00", "5.00", "100.00"],
	["tourname7","desc7", true, "extraf7",GolfCourse.fourth.id,  DateTime.new(2016,11,30), "0.00", "6.00", "200.00"],
	["tourname8","desc8", true, "extraf8",GolfCourse.fourth.id,  DateTime.new(2016,11,29), "0.00", "6.00", "200.00"],
	["Feature Tournament1", "Testing the Tourney on Homepage", true, "extrafeatures", GolfCourse.fourth.id, DateTime.now, "0.00", "4.00", "50.00"]
]

tournaments_list.each do |name, description, ispublic, extrafeatures, golfid, date, pricePlayer, priceSpectator, priceSponsor|
	Tournament.create(name: name, description: description, ispublic: ispublic, extrafeatures: extrafeatures, golf_course_id: golfid, date: date, pricePlayer: pricePlayer, priceSpectator: priceSpectator, priceSponsor: priceSponsor)
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

#each bit of adminrights column represents a privilege
#bit 0 - edit tournament info
#bit 1 - manage tee sheets (including teams)
#bit 2 - add other people as admins to tournament
#etc. 
tournament_organizers_list = [
	#these are the primary organizers who have full privileges 
	#(not sure how many bits we'll need - 10 should be plenty)
	[Person.first.id,Tournament.first.id, 1023],
	[Person.second.id,Tournament.second.id, 1023],
	[Person.third.id,Tournament.third.id, 1023],
	[Person.fourth.id,Tournament.fourth.id, 1023],
	[Person.fifth.id,Tournament.fifth.id, 1023],
	[6, 6, 1023],
	[7, 7, 1023],
	#other tournament admins with restricted set of privileges
	[14, 1, 3],
	[14, 2, 2],
	[14, 3, 2],
	[14, 4, 4],
	[14, 5, 6],
	[14, 6, 0],
]

tournament_organizers_list.each do | person_id, tournament_id, adminrights|
	TournamentOrganizer.create(person_id: person_id, tournament_id: tournament_id, adminrights: adminrights)
end

#For now, create one golf_course_organizer for each golf_course
golf_course_organizers_list = [
	[Person.first.id,GolfCourse.first.id, 0],
	[Person.second.id,GolfCourse.second.id, 1],
	[Person.third.id,GolfCourse.third.id, 1],
	[Person.fourth.id,GolfCourse.fourth.id, 0],
	[Person.fifth.id,GolfCourse.fifth.id, 0],
	[6, 6, 2],
	[7, 7, 1],
]

golf_course_organizers_list.each do | person_id, golf_course_id, adminrights|
	GolfCourseOrganizer.create(person_id: person_id, golf_course_id: golf_course_id, adminrights: adminrights)
end

sponsors_list = [
	[Person.first.id,Tournament.fifth.id, "Rounddex", "rounddex.com", "contactus@roundex.com"],
	[17,Tournament.first.id, "Quadplex", "quadplex.com", "contactus@quadplex.com"],
	[17,Tournament.second.id, "tresplanet", "tresplanet.com", "contactus@tresplanet.com"],
	[Person.fourth.id,Tournament.second.id, "tristone", "tristone.com", "contactus@tristone.com"],
	[Person.fifth.id,Tournament.first.id, "golddrill", "golddrill.com", "contactus@golddrill.com"],
]

sponsors_list.each do |person_id, tournament_id, name, website, contact_info|
	Sponsor.create(person_id: person_id, tournament_id: tournament_id, name: name, website: website, contact_info: contact_info)
end

#Note: When adding players, make sure that the person is not already registered for the
#tournament as an organizer, sponsor, etc. 
players_list = [
	[16, Tournament.first.id, 1],	#1
	[Person.first.id, Tournament.second.id, 3],	#2
	[Person.first.id, Tournament.third.id, nil],	#3
	[Person.first.id, Tournament.fourth.id, nil],	#4
	
	[Person.second.id, Tournament.first.id, 1],	#5
	[16, Tournament.second.id, 3],	#6
	[Person.second.id, Tournament.fourth.id, nil],	#7
	
	[Person.third.id, Tournament.first.id, 2],	#8
	[Person.third.id, Tournament.fourth.id, nil],	#9
	[Person.third.id, Tournament.fifth.id, nil],	#10
	[Person.third.id, 6, nil],	#11
	
	[Person.fourth.id, Tournament.first.id, 2],	#12
	[Person.fourth.id, Tournament.third.id, nil],	#13
	
	[Person.fifth.id, Tournament.first.id, 1],	#14
	[Person.fifth.id, Tournament.third.id, nil],	#15
	[Person.fifth.id, Tournament.fourth.id, nil],	#16
	
	[6, Tournament.first.id, 1],	#17
	[6, Tournament.second.id, nil],	#18
	[6, Tournament.fourth.id, nil],	#19
	
	[7, Tournament.first.id, 2],	#20
	[7, Tournament.second.id, 3],	#21
	[7, Tournament.fourth.id, nil],	#22
	
	[11, Tournament.first.id, 2],	#23
	[11, Tournament.second.id, 3],	#24
	[11, Tournament.fourth.id, nil],	#25
]

players_list.each do |person_id, tournament_id, team_id|
	Player.create(person_id: person_id, tournament_id: tournament_id, team_id: team_id)
end

#Create a ticket for each player, sponsor, and tournament_organizer 
#ticket types:
#1 - Player
#2 - Sponsor
#3 - Spectator
#4 - Tournament organizer
tickets_list = [[3, 12, Tournament.first.id, true],
                [3, 13, Tournament.first.id], true,
				[3, 12, Tournament.second.id, true],
				[3, 13, Tournament.second.id, true],
				[3, 6, Tournament.third.id, true],
				[3, 7, Tournament.third.id, true],
				[3, 12, Tournament.third.id, true],
				[3, 13, Tournament.third.id, true],
				[3, 6, Tournament.fifth.id, true],
				[3, 7, Tournament.fifth.id, true],
				[3, 11, Tournament.fifth.id, true],
				[3, 2, 7, true],
				[3, 5, 7, true]
				]
players_list.each do |person_id, tournament_id|
	tickets_list.push([1,person_id,tournament_id, true])
end

sponsors_list.each do |person_id, tournament_id|
	tickets_list.push([2,person_id,tournament_id, true])
end

tournament_organizers_list.each do |person_id, tournament_id|
	tickets_list.push([4,person_id,tournament_id, true])
end
#spectators
tickets_list.push([3])

tickets_list.each do |tickettype, person_id, tournament_id, paid|
	Ticket.create(tickettype: tickettype, person_id: person_id, tournament_id: tournament_id, has_paid: paid)
end

teams_list = [
	[1, Tournament.first.id, 1, 5, 14, 17], 
	[2, Tournament.first.id, 20, 23, 12, 8], 
	[1, Tournament.second.id, 3, 6, 24, 21],
	[1, Tournament.offset(5).fourth.id, 3, 6, 24, 21],
	[2, Tournament.offset(5).fourth.id, 1, 5, 22, 20]
]

teams_list.each do |team_num, tournamentid, p1, p2, p3, p4|
	Team.create( team_num: team_num, tournament_id: tournamentid, p1_id: p1, p2_id: p2, p3_id: p3, p4_id: p4)
end


scores_list = [
	["K.Lowry","Red","Augusta","Tourney","USA",0,0,DateTime.now],
	["J.Sullinger","Red","Augusta","Tourney","USA",0,0,DateTime.now],
	["D.Carroll","Red","Augusta","Tourney","USA",0,0,DateTime.now],
	["C.Joseph","White","Augusta","Tourney","USA",0,0,DateTime.now],
	["N.Powell","White","Augusta","Tourney","USA",0,0,DateTime.now],
	["L.James","Gold","Loren Place","Tourna","Toronto",0,0,DateTime.now],
	["K.Irving","Gold","Loren Place","Tourna","Toronto",0,0,DateTime.now],
	["J.Smith","Wine","Loren Place","Tourna","Toronto",0,0,DateTime.now],
	["K.Love","Wine","Loren Place","Tourna","Toronto",0,0,DateTime.now],
	["S.Curry","Yellow","CME Group Tour","Tours","Hamilton",0,0,DateTime.now],
	["K.Durant","Blue","CME Group Tour","Tours","Hamilton",0,0,DateTime.now],
	["K.Thompson","Yellow","CME Group Tour","Tours","Hamilton",0,0,DateTime.now],
	["D.Green","Blue","CME Group Tour","Tours","Hamilton",0,0,DateTime.now]
]

scores_list.each do |name, team, golfcourse, tournament, location, score, hole,date|
	Score.create(name: name, team: team, golfcourse: golfcourse, tournament: tournament,location: location, score: score, hole: hole,date: date)
end

#temp_player = Player.find_by(id: 1)
#temp_player.team_id = 2
#temp_player = Player.find_by(id: )
