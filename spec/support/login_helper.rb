module LoginHelper
	def fill_in_signin_fields
		fill_in "user[email]", with: "1@email.com"
		fill_in "user[password]", with: "password"
		click_button "Log in"
	end
end