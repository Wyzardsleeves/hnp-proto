Rails.application.routes.draw do

  resources :faqs

  devise_for :users
  get 'home/contact'
  get 'home/faq'
  get 'home/index'
  get 'home/forum'

  resources :posts do
    resources :comments
  end

  root 'posts#index'

end
