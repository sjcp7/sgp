Rails.application.routes.draw do
  get 'batches/new'
  get 'courses/new'
  devise_for :users
  resources :teachers
  resources :students
  resources :subjects
  resources :courses
  resources :batches
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
