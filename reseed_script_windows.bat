del db\development.sqlite3
del db\schema.rb
rake db:migrate
rake db:setup
rake db:seed