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
  
  root 'posts#index'

end
