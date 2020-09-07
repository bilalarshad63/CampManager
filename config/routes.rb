Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', passwords: 'passwords' }
  resources :privacy, only: [:index]

  # admin Routes
  devise_for :admins, controllers: { registrations: 'admin/registrations', sessions: 'admin/sessions' }
  get '/admin', to: 'home_page_admins#index', as: 'homepage'
  get '/admin/users/new', to: 'home_page_admins#new_user', as: 'new_user_by_admin'
  get '/admin/users/:id(.:format)/show', to: 'home_page_admins#show_user', as: 'show_user_by_admin'
  get '/admin/users/:id(.:format)/edit', to: 'home_page_admins#edit_user', as: 'edit_user_by_admin'
  patch '/admin/users/:id(.:format)/update', to: 'home_page_admins#update_user', as: 'update_user_by_admin'
  post '/admin/users/create', to: 'home_page_admins#create_user', as: 'create_user_by_admin'
  delete 'users/:id(.:format)/destroy', to: 'home_page_admins#destroy', as: 'destroy_user_by_admin'

  root 'home#index'
end
