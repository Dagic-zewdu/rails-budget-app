Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get '/user/sign_out' => 'devise/sessions#destroy'
  end
  resources :transacs
  resources :categories
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'static_pages#splash'
end
