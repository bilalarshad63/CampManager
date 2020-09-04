Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: "registrations"} 
  

  resources :privacy, only: [:index] 


#admins Routes
  devise_for :admins, controllers: {registrations: "admin/registrations",sessions: 'admin/sessions'}
  get '/admin', :to => 'home_page_admins#index' , as: 'homepage'
  get '/admin/users/:id(.:format)/show', :to => 'home_page_admins#show_user' , as: 'show_user_by_admin'
  get '/admin/users/:id(.:format)/edit', :to => 'home_page_admins#edit_user' , as: 'edit_user_by_admin'
  put '/admin/users/:id(.:format)/update', :to => 'home_page_admins#update_user' , as: 'update_user_by_admin'
  delete 'users/:id(.:format)/destroy', :to => 'home_page_admins#destroy' , as: 'destroy_user_by_admin'
  
	
  
  root 'home#index'

end
