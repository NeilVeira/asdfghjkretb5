class WebsiteAdminsController < ApplicationController
	before_action :authenticate_admin!
	
	def index
		@website_admins = WebsiteAdmin.all
	end
	
	def show
		@website_admin = WebsiteAdmin.find(params[:id])
		redirect_to @website_admin.person
	end
	
	def new 
		@website_admin = WebsiteAdmin.new
	end
	
	def create
		@website_admin = WebsiteAdmin.new(website_admin_params)
		if website_admin.save
			redirect_to website_admins_path
		else
			render 'new'
		end
	end
	
	#Are edit & update actually necessary? Can just modify the person
	#object using its edit action.
	def edit
		@website_admin = WebsiteAdmin.find(params[:id])
	end
	
	def update
		@website_admin = WebsiteAdmin.find(params[:id])
		@website_admin.update(website_admin_params)
		redirect_to @website_admin
	end
		
	def destroy
		@website_admin = WebsiteAdmin.find(params[:id])
		@website_admin.person.destroy #delete corresponding person object
		@website_admin.destroy
		redirect_to website_admins_path
	end
	
	private
		def website_admin_params
			params.require(:website_admin).permit(:person, :adminrights)
		end
		
end
