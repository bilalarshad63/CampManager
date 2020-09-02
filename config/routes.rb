Rails.application.routes.draw do


  root 'home#index'
  devise_for :users, controllers: {registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :privacy, only: [:index]

  delete 'users/:id(.:format)/destroy', :to => 'home_page_admins#destroy' , as: 'destroy_user'
  get '/admin', :to => 'home_page_admins#index' , as: 'homepage'

	
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
