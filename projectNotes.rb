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

#example of page render
describe "GET index" do
  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end
end

#example of page


#------------------------------------------------------------------------------------

#controllers
rails generate controller controllerName optView1 optView2  #must be pluaral
rails generate controller Topics index new edit  #generates controller and views

#models
rails generate model modelName  #must be singluar
rails generate model Topics

#
rails g migration add_newParam_name_to_modelName newParam_name:type
rails g migration add_user_id_to_posts user_id:integer  #example


#routes
root 'controllerName#optView1'    #creates root ex) root 'home#index'


#Forum notes
Users has_many :posts
Users has_many :comments

Posts belongs_to :user
Posts has_many :comments

Comments belongs_to :user
Comments belongs_to :post

rails g model post title:string content:text
rake db:migrate
rails g controller posts
add def index end to posts_controller
touch app/views/posts/index.html.erb

#gems to add
gem 'haml', '~>4.0.5'
gem 'simple_form', '~> 3.0.2'
gem 'devise', '~> 3.4.1'

#add more features to the post controller
def index
  @posts = Post.all.order("created_at DESC")
end
def new
  @posts = Post.new
end
def create
  @post = Post.new(post_params)

  if @post.save
    redirect_to @post
  else
    render 'new'
  end
end

private

def find_post
  @post = Post.find(params[:id])
end

def post_params
  params.require(:post).permit(:title, :content)
end

#add to top of controller for DRY
before_action :find_post, only: [:show, :edit, :update, :destory]

#create form that will be reused
touch app/views/posts/_form.html.erb

#add to form
= simple_form_for @post do |f|
  = f.input :title
  = f.input :content
  = f.submit

#add a show controller for the template
def show
  @post = Post.find(params[:id])
end

#add for update controller for edit page
def update
  if @post.update(post_params)
    redirect_to @post
  else
    render 'edit'
  end
end

#add destroy controller for destroy function
def destroy
  @post.destroy
  redirect_to root_path
end

#add functionality to post show view
= link_to "Home", root_path
= link_to "Return to Posts", post_path
= link_to "Edit", edit_post_path(@post)
= link_to "Delete", post_path(@post), method: :delete, data: {confirm: "Are you sure?"}

#add to

#populate index.html.erb
- @posts.each do |post|
  %h2= post.title
  %p
    Published at
    = time_ago_in_words(post.created_at)

#create a user_id after devise install
rails g migration add_user_id_to_posts user_id:integer

#add to index HTML to track user_id
= post.user_id.email

#after adding devise gem
@post = current_user.posts.build              #add this to new controller in posts
@post = current_user.posts.build(post_params) #add this to create controller in posts

#wrap posts.index in a post div with classname of posts and add date and title class to others
#posts
  - @posts.each do |post|
    %h3.title= link_to post.title, post
    %p.date
      Published at
      = time_ago_in_words(post.created_at)
      by
      = post.user.email

#add post class to show.html
#post
  %h1= @post.title
  %p= @post.content

  = link_to "Posts", root_path
  = link_to "Edit", edit_post_path(@post)
  = link_to "Delete", post_path(@post), method: :delete, data: {confirm: "Are you sure?"}

#add to keep out unsigned in people
-if user_signed_in?
  = link_to "New Post", new_post_path, class: "btn btn-success"

#add to posts controller
before_action :authenticate_user!, only: [:index, :show]  #prevents url'ing to new post

#generate comments
rails g model Comment content:text post:references user:references  #creates a content model and mokes comments belong to a post and user
has_many :comments  #add to post model
has_many :comments  #add to user model

#add to routes for routing comments in a nest
resources :posts do
  resources :comments
end

#generate controller for comments
rails g controller Comments

#add to controller
def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.create(params[:comment].permit(:comment))
  @comment.user_id = current_user.id

  if @comment.save
    redirect_to post_path(@post)
  else
    render 'new'
  end
end

#add some views to comments views
touch app/comments/_form.html.erb
touch app/comments/_comment.html.erb

.comment
  %p= comment.comment #add to _comment.html

= simple_form_for([@post, @post.comments.build]) do |f| #add to _form.html
  = f.input :comment
  = f.submit

#add to show.html in post views
#comments
  %h2= @post.comments.count
  = render @post.comments

  %h3 Reply to thread
  = render "comments/form"

#add comments user
%p= comment.user.email #in _comment.html

#add a destroy function for the comment in comments conroller
def destroy
  @post = Post.find(params[:post_id])
  @comment = @post.comments.find(params[:id])

  @comment.destroy
  redirect_to post_path(@post)
end

#add to _comment.html
= link_to "Delete", [comment.post, comment], method: :delete, class:"btn btn-danger", data: {confirm: "Are you sure?"}

#add to comment controller
def edit
  @post = Post.find(params[:post_id])
  @comment = @post.comments.find(param[:id])
end

def update
  @post = Post.find(params[:post_id])
  @comment = @post.comments.find(param[:id])

  if @comment.update(params[:comment].permit(:comment))
    redirect_to post_path(@post)
  else
    render 'edit'
  end
end

#add to _comment.html
= link_to "Edit", edit_post_comment_path(comment.post, comment), class:"btn btn-primary"

#create an edit.html
%h1 Edit Reply

= simple_form_for([@post, @comment]) do |f|
  = f.input :comment
  = f.submit


#-------------------------------------------------------------------------------------

#Installing bootstrap in rails
gem 'bootstrap-sass'  #add to gemfile

mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss #in command line to rename application.css to .scss
@import "bootstrap-sprockets";  #add to application.scss
@import "bootstrap";            #add to application.scss

//= require bootstrap #add to application.js
<meta name="viewport" content="width=device-width, initial-scale=1">  #add to application.html.erb




#fix the logout for FAQ
