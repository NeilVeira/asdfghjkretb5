Rails.application.routes.draw do

  get 'contact_us/index'

  get 'partner/index'

  get 'story/index'

  get 'faq/index'

  get 'feature/index'

  get 'site_map/index'

  get 'privacy/index'

  get 'serviceterm/index'

    devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
    get 'home_page/index'
    get 'people/profile', to: 'people#profile'
    get 'people/portal', to: 'people#portal'
    get 'people/user_tourney', to: 'people#user_tourney'
    get 'people/user_ticket', to: 'people#user_ticket'

    resources :people 
    resources :tournaments
    resources :golf_courses
    resources :tickets
    resources :teams
    resources :tournament_organizers
    resources :golf_course_organizers
    resources :website_admins
    resources :players
    resources :sponsors

    root 'home_page#index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	# setup is used to pass the tournament_id to the tickets#new action when registering
	get 'tickets/setup/:id', to: 'tickets#setup', as: :setup
	
end
