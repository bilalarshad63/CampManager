Rails.application.routes.draw do
  devise_for :admins
  root 'home#index'
  devise_for :users, controllers: { registrations: 'registrations', passwords: 'passwords' }
  resources :privacy, only: [:index]
  delete 'users/:id(.:format)/destroy', to: 'home_page_admins#destroy', as: 'destroy_user'
  get '/admin', to: 'home_page_admins#index', as: 'homepage'
  get '/admin/users/:id(.:format)/show', to: 'home_page_admins#show_user', as: 'show_user'
end
