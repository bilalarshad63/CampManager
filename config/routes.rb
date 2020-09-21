Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', passwords: 'passwords' }
  resources :users
  resources :camps
  resources :camp_applications do
    member do
      get 'camp/:camp_id/profile', to: 'camp_applications#profile', as: 'profile'
    end
  end
  resources :privacy, only: [:index]

  devise_for :admins, controllers: { registrations: 'devise_admin/registrations', sessions: 'devise_admin/sessions' }
  namespace :admin_panel do
    get '/admin', to: 'home_page_admins#index', as: 'homepage'
    resources :admins
    resources :users
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

  root 'camps#index'
end
