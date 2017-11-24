Rails.application.routes.draw do

=begin
  get 'faqs/index'
  get 'faqs/show'
  get 'faqs/new'
  get 'faqs/edit'
=end
  resources :faqs

  devise_for :users
  get 'home/contact'
  get 'home/faq'
  get 'home/index'
  get 'home/forum'
  #root 'home#index'

  resources :posts do
    resources :comments
  end



  root 'posts#index'

end
