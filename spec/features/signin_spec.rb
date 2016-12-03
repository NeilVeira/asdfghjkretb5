require 'rails_helper'

feature "signin" do
	let(:user) {FactoryGirl.create(:valid_user)}
	
	scenario "visiting the site to sign in" do
		visit root_path
		expect(page).to have_link("Login", visible: false)
		find('a', :text => "Login", visible: false).click
		
		save_and_open_page

		fill_in_signin_fields
		
		save_and_open_page
		
		expect(page).to have_content("Signed in successfully.")
	end
end
