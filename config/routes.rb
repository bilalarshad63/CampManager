Rails.application.routes.draw do
 
  devise_for :users, controllers: { registrations: 'registrations', passwords: 'passwords' }
  resources :users
  resources :camp_applications do
    member do
      get 'camp/:camp_id/profile', to: 'camp_applications#profile', as: 'profile'
    end
  end
 
  resources :privacy, only: [:index]
 
  resources :camp_locations do
    collection do
      get 'export_csv'
    end
  end

  devise_for :admins, controllers: { registrations: 'devise_admin/registrations', sessions: 'devise_admin/sessions' }
  resources :admins


  
  get '/admin', to: 'home_page_admins#index', as: 'homepage'
  get '/admin/users/new', to: 'home_page_admins#new_user', as: 'new_user_by_admin'
  post '/admin/users/create', to: 'home_page_admins#create_user', as: 'create_user_by_admin'

  resources :camps do
    member do
      patch :toggle_status
    end
    collection do
      post 'intro', to: 'camps#introduction', as: 'intro'
    end
  end
  
  root 'users#index'
end
