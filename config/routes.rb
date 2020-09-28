Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', passwords: 'passwords' }
  resources :users
  resources :camps
  resources :camp_applications do
    member do
      get 'camp/:camp_id/profile', to: 'camp_applications#profile', as: 'profile'
    end
    member do
      post '/auto_save', to: 'camp_applications#auto_save', as: 'auto_save'
    end
  end
  resources :privacy, only: [:index]

  devise_for :admins, controllers: { registrations: 'devise_admin/registrations', sessions: 'devise_admin/sessions' }
  namespace :admin_panel do
    get '/admin', to: 'home_page_admins#index', as: 'homepage'
    resources :admins
    resources :users
    resources :camp_applications
    resources :camp_locations do
      collection do
        get 'export_csv'
      end
    end
    resources :camps do
      member do
        patch :toggle_status
      end
    end
  end
  namespace :api do
    resources :camp_applications
  end

  namespace :api do
    namespace :v1 do
      resources :camps, only: %i[index]
    end
    namespace :v2 do
      post :auth, to: 'authentication#create'
      resources :camps, only: %i[index]
    end
  end

  root 'camps#index'

  match '*path', to: 'application#error_404', via: :all

end
