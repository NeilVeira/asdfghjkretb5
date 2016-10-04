# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
people_list = [
	["FirstName1", "LastName1", "dob1", "address1", "phone1","email1"],["FirstName2", "LastName2", "dob2", "address2", "phone2","email2"],["FirstName3", "LastName3", "dob3", "address3", "phone3","email3"],
["FN3", "LN3", "dob3", "address3", "phone3","email3"],["FN4", "LN4", "dob4", "address4", "phone4","email4"],["FN5", "LN5", "d5", "add5", "ph5","em5"],["FN6", "LN6", "d6", "add6", "ph6","em6"]
]

people_list.each do |firstname,lastname,dob,address,phone,email|
	Person.create(firstname: firstname, lastname: lastname, dob: dob, address: address, phone: phone, email: email)
end

tournaments_list = [
	["name1","description1", true, "extrafeatures1"],["name2","description2", true, "extrafeatures2"],["name3","description3", true, "extrafeatures3"],["name4","description4", false, "extrafeatures4"],
	["name5","description5", false, "extrafeatures5"],["name6","desc6", false, "extraf6"]
]

tournaments_list.each do |name, description, ispublic, extrafeatures|
	Tournament.create(name: name, description: description, ispublic: ispublic, extrafeatures: extrafeatures)
end