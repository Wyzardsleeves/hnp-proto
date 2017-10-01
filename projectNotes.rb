#generate the rails app
rails optionalVersion new optExemption
rails _4.2.5_ new hnp-proto -T #makes a rails app with version 4.2.5 without test

#installing gems
bundle install                          #installs gems
bundle install --without production     #installs gems wihtout production

#database
rake db:create          #creates new database for app to use
rake db:migrate         #migrates new data to the database
