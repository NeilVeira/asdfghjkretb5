require 'rails_helper'

feature "create_tournament" do
	
	def fill_in_tournament_info
		fill_in "tournament[name]", with: "My Tournament"
		fill_in "tournament[description]", with: "The best tournament ever!"
		choose "tournament[ispublic]", :option => "1"
		
		#select "option[2]", from: "tournament[golf_course_id]"
		find('#tournament_golf_course_id').find(:xpath, 'option[5]').select_option
		
		find('#tournament_date_1i').find(:xpath, 'option[1]').select_option
		find('#tournament_date_2i').find(:xpath, 'option[3]').select_option
		find('#tournament_date_3i').find(:xpath, 'option[20]').select_option
		find('#tournament_date_4i').find(:xpath, 'option[1]').select_option
		find('#tournament_date_5i').find(:xpath, 'option[50]').select_option
		
		attach_file("tournament[image]", "spec/test_tournament_image.jpeg")
		
		fill_in "tournament[extrafeatures]", with: "Free lunch!"
		
		click_button "Create Tournament"
	end
	
	scenario "creating a tournament" do
		visit "/tournaments/new"
		#should not be able to access tournaments/new without logging in
		expect(page).to have_text("Log in") 
		fill_in_signin_fields
		
		expect(page).to have_text("Create a Tournament")
		fill_in_tournament_info

		expect(page).to have_current_path(/\/tickets\/\d+/)
		expect(page).to have_text("Transaction Successful")
		click_link "Continue to tournament"
		
		save_and_open_page
		
		expect(page).to have_current_path(/\/tournaments\/\d+/)
		expect(page).to have_text("My Tournament")
	end

end