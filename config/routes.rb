Rails.application.routes.draw do

  devise_for :users
  get 'home/contact'
  get 'home/faq'
  get 'home/index'
  get 'home/forum'
  #root 'home#index'

  resources :posts do
    resources :comments
  end

=begin of theoretical solution for adding a "topicss" branch
  resources :topics do
    resources :posts do
      resources :comments
    end
  end
=end

  root 'posts#index'

end
