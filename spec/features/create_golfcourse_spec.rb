require 'rails_helper'

feature "create_golfcourse" do
	
	def fill_in_golfcourse_info
		fill_in "golf_course[name]", with: "My golf_course"
		fill_in "golf_course[description]", with: "The best golf_course ever!"
		fill_in "golf_course[address_attributes][streetNumber]", with: "123"
		fill_in "golf_course[address_attributes][streetName]", with: "golfstreet"
		fill_in "golf_course[address_attributes][city]", with: "golfcity"
		fill_in "golf_course[address_attributes][province]", with: "golfprovince"
		fill_in "golf_course[address_attributes][country]", with: "golfcountry"
		fill_in "golf_course[address_attributes][postalCode]", with: "G1P 4O2"
		
		attach_file("golf_course[image]", "spec/test_golfcourse_image.jpg")
		
		click_button "Create Golf course"
	end
	
	scenario "creating a golfcourse" do
		visit "/golf_courses/new"
		#should not be able to access golf_courses/new without logging in
		expect(page).to have_text("Log in") 
		fill_in_signin_fields
		
		expect(page).to have_text("Register a new golf course")
		fill_in_golfcourse_info

		save_and_open_page
		
		expect(page).to have_text("You are an organizer for this golf course!")

	end

end