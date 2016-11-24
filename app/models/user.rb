class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :linkedin]
		 
  def self.from_omniauth(auth)
	where(email: auth.info.email).first_or_create do |user|
	  #user.email = auth.info.email
	  if auth.provider == 'facebook'
		user.fb_provider = auth.provider
	  else
		user.in_provider = auth.provider
	  end
	  user.uid = auth.uid
	  user.password = Devise.friendly_token[0,20]
	end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
end
