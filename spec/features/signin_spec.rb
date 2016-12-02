require 'rails_helper'

feature "signin in" do
	let(:user) {FactoryGirl.create(:user)}
	
	def fill_in_signin_fields
		fill_in "user[email]", with: user.email
		fill_in "user[password]", with: user.password
		click_button "Log in"
	end
	
	scenario "visiting the site to sign in" do
		visit root_path
		expect(page).to have_link("Login", visible: false)
		#find("Login", visible: false).click
		find('a', :text => "Login", visible: false).click
		save_and_open_page

		fill_in_signin_fields
		expect(page).to have_content("Signed in successfully.")
		
		save_and_open_page
	end
end
