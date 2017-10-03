#generate the rails app
rails optionalVersion new optExemption
rails _4.2.5_ new hnp-proto -T #makes a rails app with version 4.2.5 without test

#installing gems
gem 'pg'                #add to :production in gemfile
gem 'sqlite3'           #move to to :development in gemfile
gem 'rails_12factor'    #for heroku I think?
#redcarpet for markdown
#paperclip for image
#pry for irb substitute

bundle install                          #installs gems
bundle install --without production     #installs gems wihtout production

#database
rake db:create          #creates new database for app to use
rake db:migrate         #migrates new data to the database
rake routes             #lets user see available routes

#heroku
heroku login              #login to heroku
heroku create             #heroku create app
git push heroku master    #push app to heroku
heroku apps:info          #heroku info

#tags in rails
<%= image_tag "blocipedia.png" %> >#import an image
<%= link_to "subjectHere", insert_here_path, class: "classname" %> >#class is optional
<%= link_to "Forums", home_forum_path, class:"btn btn-success" %>  >
<%= link_to "Delete", @controllerName, home_forum_path, method: :delete, class: 'btn btn-danger', data: {confirm: 'Are you sure you want to delete this entry?'} %>          >#this onw might be wrong


#testing-----------------------------------------------------------------------------
gem 'rspec-rails', '~> 3.0'                   #add to :development, :test in gemfile
rails generate rspec:install                  #generates respec for project
expect(response).to render_template("optView1")  #expects a render of the template

#example
describe "GET index" do
  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end
end
#------------------------------------------------------------------------------------

#controllers
rails generate controller controllerName optView1 optView2  #generates controller and views

#models
rails generate model modelName

#routes
root 'controllerName#optView1'    #creates root ex) root 'home#index'

#-------------------------------------------------------------------------------------

#Installing bootstrap in rails
gem 'bootstrap-sass'  #add to gemfile

mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss #in command line to rename application.css to .scss
@import "bootstrap-sprockets";  #add to application.scss
@import "bootstrap";            #add to application.scss

//= require bootstrap #add to application.js
<meta name="viewport" content="width=device-width, initial-scale=1">  #add to application.html.erb
