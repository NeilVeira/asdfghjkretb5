FactoryGirl.define do
	factory :user do
		email "1@email.com"
		password "password"
	end
	
	factory :valid_user, class: User do
		email "1@email.com"
		password "password"
	end
	
end