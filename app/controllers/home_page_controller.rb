class HomePageController < ApplicationController
	def index
		if user_signed_in?
			if user_exists?
				if user_is_admin?
					render 'admin_user'
				else
					render 'regular_user'
				end
			else
				render 'no_user'
			end
		else
			render 'no_user'
		end
	end
end
