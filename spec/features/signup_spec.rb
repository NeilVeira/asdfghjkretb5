require 'rails_helper'

feature "signup" do
	
	def fill_in_signup_user_fields
		fill_in "user[email]", with: "newacct@email.com"
		fill_in "user[password]", with: "password"
		fill_in "user[password_confirmation]", with: "password"
		click_button "Sign up"
	end
	
	def fill_in_signup_person_fields
		fill_in "person[firstname]", with: "TestFirstName"
		fill_in "person[lastname]", with: "TestLastName"
		find('#person_dob_2i').find(:xpath, 'option[2]').select_option
		find('#person_dob_3i').find(:xpath, 'option[28]').select_option
		find('#person_dob_1i').find(:xpath, 'option[30]').select_option
		fill_in "person[phone]", with: "123-456-7890"
		fill_in "person[address_attributes][apartmentNumber]", with: "123"
		fill_in "person[address_attributes][streetNumber]", with: "6"
		fill_in "person[address_attributes][streetName]", with: "TestStreet"
		fill_in "person[address_attributes][city]", with: "Toronto"
		fill_in "person[address_attributes][province]", with: "Ontario"
		fill_in "person[address_attributes][country]", with: "Canada"
		fill_in "person[address_attributes][postalCode]", with: "M1C E4F"
		click_button "Save"
	end
	
	scenario "visiting the site to sign up" do
		visit root_path
		expect(page).to have_link("Sign Up", visible: false)
		find('a', :text => "Sign Up", visible: false).click
		
		save_and_open_page

		fill_in_signup_user_fields		
		fill_in_signup_person_fields
			
		save_and_open_page
		
		expect(page).to have_current_path(people_profile_path, only_path: true)
		
		expect(page).to have_content("Profile")
	end
end
