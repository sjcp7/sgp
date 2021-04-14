Rails.application.routes.draw do
  devise_for :users
  resources :batches, only: %i[ index show ]
  resources :lectures, only: %i[ show ] do
    resources :tests, only: %i[ index ], shallow: true
  end

  scope '/admin' do
    resources :teachers, :students, :courses, :subjects
  end

  namespace :admin do 
    resources :batches do
      resources :lectures, shallow: true do
        resources :tests, shallow: true
      end
    end
  end
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
