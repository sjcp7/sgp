Rails.application.routes.draw do
  devise_for :users
  resources :batches do
    resources :lectures, shallow: true
  end

  resources :lectures do
    resources :tests, shallow: true do
      resources :student_tests, only: %i[ index create update ], shallow: true
    end
  end

  resources :teachers, :students, :courses, :subjects, :admins

 
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
