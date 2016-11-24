class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook	
	auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
	if user_signed_in?
		if @user == current_user # linking accounts, set provider
			if auth.provider == 'facebook'
				@user.fb_provider = auth.provider
			else
				@user.in_provider = auth.provider
			end
			@user.save
			@person = current_person
			redirect_to '/people/profile'		
		else
			redirect_to '/people/profile', :flash => { :error => "Email does not match!" }
		end
	elsif (Person.exists?(user_id: @user) == false)
		
		name = auth.info.name
		data = name.split(' ').values_at(0, -1)
	
		session[:data] = data		
	
		sign_in @user
		redirect_to new_person_path	
    elsif @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  def linkedin
	auth = request.env["omniauth.auth"]  
    @user = User.from_omniauth(request.env["omniauth.auth"])
	if user_signed_in?
		if @user == current_user # linking accounts, set provider
			if auth.provider == 'facebook'
				@user.fb_provider = auth.provider
			else
				@user.in_provider = auth.provider
			end
			@user.save
			@person = current_person
			redirect_to '/people/profile'	
		else
			redirect_to '/people/profile', :flash => { :error => "Email does not match!" }
		end	
	elsif (Person.exists?(user_id: @user) == false)
		
		name = auth.info.name
		data = name.split(' ').values_at(0, -1)
	
		session[:data] = data		
	
		sign_in @user
		redirect_to new_person_path	
    elsif @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "LinkedIn") if is_navigational_format?
    else
      session["devise.linkedin_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end