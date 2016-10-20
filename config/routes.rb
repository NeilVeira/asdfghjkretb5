Rails.application.routes.draw do

    devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
    get 'home_page/index'
    get 'people/profile', to: 'people#profile'

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

end
