require 'rails_helper'

feature "routing" do
	
	scenario "routing through the site links" do
		visit root_path
		expect(page).to have_link("Sign Up", visible: false)
		
		expect(page).to have_link("Golf Courses", visible: false)
		find('a', :text => "Golf Courses", visible: false).click
		expect(page).to have_text("Golf Courses on Record")
				
		expect(page).to have_link("Tournaments", visible: false)
		find('a', :text => "Tournaments", visible: false).click
		expect(page).to have_text("Upcoming Tournaments")
		
		expect(page).to have_link("Contact Us", visible: false)
		find('a', :text => "Contact Us", visible: false).click
		expect(page).to have_text("Contact Us")
		
		expect(page).to have_link("Partners", visible: false)
		find('a', :text => "Partners", visible: false).click
		expect(page).to have_text("Our Partners")
		
		expect(page).to have_link("Our Story", visible: false)
		find('a', :text => "Our Story", visible: false).click
		expect(page).to have_text("Our Story")
		
		expect(page).to have_link("FAQ", visible: false)
		find('a', :text => "FAQ", visible: false).click
		expect(page).to have_text("Frequently Asked Questions")
		
		expect(page).to have_link("Features", visible: false)
		find('a', :text => "Features", visible: false).click
		expect(page).to have_text("Our Features")
		
		expect(page).to have_link("Terms of Service", visible: false)
		find('a', :text => "Terms of Service", visible: false).click
		expect(page).to have_text("Terms of Service (\"Terms\")")
		
		expect(page).to have_link("Privacy Info", visible: false)
		find('a', :text => "Privacy Info", visible: false).click
		expect(page).to have_text("Privacy Info")
		
		expect(page).to have_link("Site Map", visible: false)
		find('a', :text => "Site Map", visible: false).click
		expect(page).to have_text("CSC444 Site Map")
		
		save_and_open_page

	end
end
