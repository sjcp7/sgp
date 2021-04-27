Rails.application.routes.draw do
  devise_for :users
  resources :batches do
    resources :lectures, shallow: true
  end

  resources :lectures do
    resources :tests, shallow: true do
      resources :student_tests, only: %i[ index update ], shallow: true
    end
  end
  resources :requests, only: %i[index show new create]

  resources :teachers, :students, :courses, :subjects, :admins
  scope '/settings' do 
    resources :school_years, :school_quarters, only: %i[ index show create update new ]
  end

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
