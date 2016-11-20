class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook	
    @user = User.from_omniauth(request.env["omniauth.auth"])	
	if (Person.exists?(user_id: @user) == false)
		auth = request.env["omniauth.auth"]
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

  def failure
    redirect_to root_path
  end
end