heroku pg:reset DATABASE_URL --confirm test-rubyonrails-app
heroku run rake db:schema:load
heroku run rake db:seed
