Rails.application.routes.draw do
    

  devise_for :users, controllers: {registrations: "registrations", passwords: "passwords"}
  resources :users
  resources :privacy, only: [:index]

  #admin Routes
  devise_for :admins, controllers: {registrations: "admin/registrations",sessions: 'admin/sessions'}
  resources :admins
  #HomePage Admin Routes
  get '/admin', :to => 'home_page_admins#index' , as: 'homepage'
  get '/admin/camps', :to => 'home_page_admins#show_camps' , as: 'homepage_camps'
  get '/admin/users/new', :to => 'home_page_admins#new_user' , as: 'new_user_by_admin'
  post '/admin/users/create', :to => 'home_page_admins#create_user' , as: 'create_user_by_admin'
  
  resources :camps do
    member do
        patch :toggle_status
    end
end

  root 'home_page_admins#index'
  
end
